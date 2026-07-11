import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decora/feature/chat/domain/entity/messages_entity.dart';

class MessagesModel extends MessagesEntity {
  MessagesModel({
    required super.id,
    required super.senderId,
    required super.text,
    super.isRead = false,
    required super.timeStamp,
    super.type = MessageType.text,
    super.imageUrl,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json, String id) {
    return MessagesModel(
      id: id,
      senderId: json['senderId'] as String,
      text: json['text'] as String? ?? '',
      timeStamp: (json['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isRead: json['isRead'] as bool? ?? false,
      type: (json['type'] as String?) == 'image'
          ? MessageType.image
          : MessageType.text,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': isRead,
      'type': type == MessageType.image ? 'image' : 'text',
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }
}