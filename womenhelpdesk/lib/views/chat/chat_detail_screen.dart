import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/auth_controller.dart';
import '../../services/chat_service.dart';
import '../../models/message_model.dart';
import '../../constants/app_colors.dart';

class ChatDetailScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatDetailScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();
  String? _receiverPhone;

  @override
  void initState() {
    super.initState();
    _fetchReceiverInfo();
  }

  Future<void> _fetchReceiverInfo() async {
    try {
      // 1. Try Users collection
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.receiverId).get();
      if (userDoc.exists) {
        setState(() {
          _receiverPhone = userDoc.data()?['phone'];
        });
        return;
      }

      // 2. Try Guardians collection fallback
      final guardianQuery = await FirebaseFirestore.instance
          .collection('guardians')
          .where('id', isEqualTo: widget.receiverId)
          .limit(1)
          .get();
          
      if (guardianQuery.docs.isNotEmpty) {
        final gData = guardianQuery.docs.first.data();
        setState(() {
          _receiverPhone = gData['guardianPhone'];
        });
      }
    } catch (e) {
      debugPrint('Error fetching receiver info: $e');
    }
  }

  void _makeCall() async {
    if (_receiverPhone == null || _receiverPhone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Phone number not found.')));
      return;
    }
    
    // Clean the phone number: remove anything that isn't a digit or +
    final cleanPhone = _receiverPhone!.replaceAll(RegExp(r'[^\d+]'), '');
    final Uri callUri = Uri.parse('tel:$cleanPhone');
    
    try {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not dial $cleanPhone')));
      }
    } catch (e) {
      debugPrint('Call Error: $e');
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final authController = Provider.of<AuthController>(context, listen: false);
    final senderId = authController.userModel?.uid ?? '';

    _chatService.sendMessage(
      senderId,
      widget.receiverId,
      _messageController.text.trim(),
    );

    _messageController.clear();
    _scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final currentUserId = authController.userModel?.uid ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 1,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiverName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const Text('Active Now', style: TextStyle(fontSize: 12, color: AppColors.successGreen)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_rounded, color: AppColors.primary),
            onPressed: _makeCall,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _chatService.getMessages(currentUserId, widget.receiverId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline_rounded, color: AppColors.error, size: 48),
                        const SizedBox(height: 16),
                        Text('Connection Error', style: TextStyle(color: AppColors.error.withOpacity(0.8), fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('Could not load messages', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }
                
                final messages = snapshot.data ?? [];
                
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.forum_outlined, size: 64, color: AppColors.primary.withOpacity(0.1)),
                        const SizedBox(height: 16),
                        const Text(
                          'Secure Chat Active',
                          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Your messages are protected.',
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }
                
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId.trim() == currentUserId.trim();
                    return _buildMessageBubble(message, isMe);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message, bool isMe) {
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isMe ? 20 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 20),
            ),
          ),
          child: Text(
            message.message,
            style: TextStyle(color: isMe ? Colors.white : AppColors.textPrimary, fontSize: 15),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12, right: isMe ? 4 : 0, left: isMe ? 0 : 4),
          child: Text(
            DateFormat('hh:mm a').format(message.timestamp),
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

