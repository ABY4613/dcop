import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message
  Future<void> sendMessage(String senderId, String receiverId, String message) async {
    final String chatId = _getChatId(senderId, receiverId);
    final String messageId = _firestore.collection('chats').doc(chatId).collection('messages').doc().id;

    final newMessage = MessageModel(
      id: messageId,
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      timestamp: DateTime.now(),
    );

    await _firestore.collection('chats').doc(chatId).set({
      'lastMessage': message,
      'lastTimestamp': Timestamp.now(),
      'participants': [senderId, receiverId],
    }, SetOptions(merge: true));

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .set(newMessage.toMap());
  }

  // Get messages stream
  Stream<List<MessageModel>> getMessages(String senderId, String receiverId) {
    final String chatId = _getChatId(senderId, receiverId);
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .snapshots()
        .map((snapshot) {
      try {
        final messages = snapshot.docs
            .map((doc) {
              try {
                return MessageModel.fromMap(doc.data());
              } catch (e) {
                debugPrint('Error parsing message ${doc.id}: $e');
                return null;
              }
            })
            .whereType<MessageModel>() // Removes nulls
            .toList();

        // Sort locally to avoid Index requirements
        messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
        return messages;
      } catch (e) {
        debugPrint('Global stream error: $e');
        return [];
      }
    });
  }

  // Get chat rooms for a user
  Stream<QuerySnapshot> getChatRooms(String userId) {
    // Note: We avoid .orderBy('lastTimestamp') here to prevent index requirements
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .snapshots();
  }

  // Utility to generate a unique chatId from two userIds
  String _getChatId(String id1, String id2) {
    final s1 = id1.trim();
    final s2 = id2.trim();
    if (s1.compareTo(s2) > 0) {
      return '${s1}_$s2';
    } else {
      return '${s2}_$s1';
    }
  }
}
