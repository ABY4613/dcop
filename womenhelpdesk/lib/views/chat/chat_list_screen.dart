import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../controllers/auth_controller.dart';
import '../../services/chat_service.dart';
import '../../constants/app_colors.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final currentUserId = authController.userModel?.uid ?? '';
    final ChatService chatService = ChatService();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: chatService.getChatRooms(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState();
          }

          final chatRooms = snapshot.data!.docs;
          
          // Sort locally to ensure latest messages are at the top
          chatRooms.sort((a, b) {
            final aData = a.data() as Map<String, dynamic>;
            final bData = b.data() as Map<String, dynamic>;
            final aTime = (aData['lastTimestamp'] as Timestamp).toDate();
            final bTime = (bData['lastTimestamp'] as Timestamp).toDate();
            return bTime.compareTo(aTime);
          });

          return ListView.builder(
            itemCount: chatRooms.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final room = chatRooms[index].data() as Map<String, dynamic>;
              final participants = room['participants'] as List<dynamic>;
              final otherUserId = participants.firstWhere((id) => id != currentUserId);
              
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(otherUserId).get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData && userSnapshot.data!.exists) {
                    final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                    return _buildChatTile(
                      context: context,
                      name: userData['name'] ?? 'User',
                      lastMessage: room['lastMessage'] ?? '',
                      time: (room['lastTimestamp'] as Timestamp).toDate(),
                      receiverId: otherUserId,
                    );
                  }
                  
                  // Fallback for guardians not yet in users collection
                  return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('guardians').where('id', isEqualTo: otherUserId).get(),
                    builder: (context, guardianSnapshot) {
                      String name = 'User';
                      if (guardianSnapshot.hasData && guardianSnapshot.data!.docs.isNotEmpty) {
                        final gData = guardianSnapshot.data!.docs.first.data() as Map<String, dynamic>;
                        name = gData['guardianName'] ?? 'Guardian';
                      }

                      return _buildChatTile(
                        context: context,
                        name: name,
                        lastMessage: room['lastMessage'] ?? '',
                        time: (room['lastTimestamp'] as Timestamp).toDate(),
                        receiverId: otherUserId,
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {},
        child: const Icon(Icons.message_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline_rounded, size: 80, color: AppColors.primary.withOpacity(0.3)),
          const SizedBox(height: 24),
          const Text(
            'No conversations yet',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Messages from your guardians will appear here.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile({
    required BuildContext context,
    required String name,
    required String lastMessage,
    required DateTime time,
    required String receiverId,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person, color: AppColors.primary, size: 30),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.successGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
              ),
            ),
          ],
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary, fontSize: 16),
            ),
            Text(
              DateFormat('hh:mm a').format(time),
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(
                receiverId: receiverId,
                receiverName: name,
              ),
            ),
          );
        },
      ),
    );
  }
}
