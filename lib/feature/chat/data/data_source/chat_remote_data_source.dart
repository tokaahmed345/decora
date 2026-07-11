
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/feature/chat/data/models/chat_room_model.dart';
import 'package:decora/feature/chat/data/models/message_model.dart';
import 'package:decora/feature/chat/data/models/serached_user_model.dart';
import 'package:decora/feature/notification/data/notification_remote_data_layer.dart/data_source/notification_remote_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChatRemoteDataSource {
  Stream<List<MessagesModel>> getMessages(String chatId);

  Stream<List<ChatRoomModel>> getUserChats(String currentUserId);


  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    String text = '',
    File? imageFile,
  });


  Future<String> createChat({
    required String currentUserId,
    required String otherUserId,
  });

  Future<String?> getExistingChatId({
    required String currentUserId,
    required String otherUserId,
  });

  Future<List<SearchedUserModel>> searchUsers({
    required String query,
    required String currentUserId,
  });

  Future<void> markChatAsRead({required String chatId, required String userId});
  
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final NotificationRemoteData notificationRemoteData;
    final SupabaseClient supabase;

  const ChatRemoteDataSourceImpl(this.firestore, {required this.notificationRemoteData, required this.supabase});

  @override
  Stream<List<MessagesModel>> getMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => MessagesModel.fromJson(doc.data(), doc.id))
          .toList();
    });
  }

  @override
  Stream<List<ChatRoomModel>> getUserChats(String currentUserId) {
    return firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final futures = snapshot.docs.map((doc) async {
        final data = doc.data();
        final participants = List<String>.from(data['participants'] as List);

        final otherUserId = participants.firstWhere(
          (id) => id != currentUserId,
          orElse: () => '',
        );

        if (otherUserId.isEmpty) return null;

        final otherUserDoc =
            await firestore.collection('user').doc(otherUserId).get();
        final otherUserData = otherUserDoc.data();

        final unreadCounts = data['unreadCounts'] as Map<String, dynamic>? ?? {};
        final myUnreadCount = (unreadCounts[currentUserId] as int?) ?? 0;

        return ChatRoomModel(
          chatId: doc.id,
          otherUserId: otherUserId,
          otherUserName: otherUserData?['name'] as String? ?? 'Unknown',
          otherUserAvatarUrl: otherUserData?['imageUrl'] as String? ?? '',
          lastMessage: data['lastMessage'] as String? ?? '',
          lastMessageTime: (data['lastMessageTime'] as Timestamp?)?.toDate(),
          unreadCount: myUnreadCount,
        );
      });

      final results = await Future.wait(futures);
      return results.whereType<ChatRoomModel>().toList();
    });
  }

  Future<String> _uploadImage({
    required String chatId,
    required File imageFile,
  }) async {
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt';
    final storagePath = '$chatId/$fileName';

    await supabase.storage.from("chat_images").upload(
          storagePath,
          imageFile,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: false,
          ),
        );

    return supabase.storage.from("chat_images").getPublicUrl(storagePath);
  }
Future<void> sendMessage({
    required String chatId,
    required String senderId,
    String text = '',
    File? imageFile,
  }) async {
    final chatRef = firestore.collection('chats').doc(chatId);

    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await _uploadImage(chatId: chatId, imageFile: imageFile);
    }

    final isImage = imageUrl != null;

    await chatRef.collection('messages').add({
      'senderId': senderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'type': isImage ? 'image' : 'text',
      if (imageUrl != null) 'imageUrl': imageUrl,
    });

    final chatDoc = await chatRef.get();
    final participants = List<String>.from(chatDoc['participants']);
    final receiverId = participants.firstWhere((id) => id != senderId);

    final lastMessagePreview = isImage ? '📷 image' : text;

    await chatRef.update({
      'lastMessage': lastMessagePreview,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCounts.$receiverId': FieldValue.increment(1),
    });

    final receiverDoc = await firestore.collection('user').doc(receiverId).get();
    final receiverToken = receiverDoc.data()?['fcmToken'] as String?;
  if (receiverToken != null) {
  try {
    await notificationRemoteData.sendPushNotification(
      token: receiverToken,
      title: 'New Message 💬',
      body: lastMessagePreview,
    );
  } catch (e) {
    // اطبع/سجّل الخطأ بس متخليش يفشل عملية إرسال الرسالة
    print('Push notification failed: $e');
  }
}
  }
  @override
  Future<String?> getExistingChatId({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final snapshot = await firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        .get();

    for (final doc in snapshot.docs) {
      final participants = List<String>.from(
        doc.data()['participants'] as List,
      );
      if (participants.contains(otherUserId)) {
        return doc.id;
      }
    }

    return null;
  }

  @override
  Future<String> createChat({
    required String currentUserId,
    required String otherUserId,
  }) async {
    final docRef = await firestore.collection('chats').add({
      'participants': [currentUserId, otherUserId],
      'lastMessage': '',
      'lastMessageTime': FieldValue.serverTimestamp(),
      'unreadCounts': {
        currentUserId: 0,
        otherUserId: 0,
      },
    });

    return docRef.id;
  }

  @override
  Future<List<SearchedUserModel>> searchUsers({
    required String query,
    required String currentUserId,
  }) async {
    if (query.trim().isEmpty) return [];

    final snapshot = await firestore
        .collection('user')
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: '$query\uf8ff')
        .limit(20)
        .get();

    return snapshot.docs
        .where((doc) => doc.id != currentUserId)
        .map((doc) => SearchedUserModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> markChatAsRead({
    required String chatId,
    required String userId,
  }) async {
    await firestore.collection('chats').doc(chatId).update({
      'unreadCounts.$userId': 0,
    });
  }
}