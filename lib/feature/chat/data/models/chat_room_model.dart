import 'package:decora/feature/chat/domain/entity/chat_room_entity.dart';

class ChatRoomModel extends ChatRoomEntity {
   ChatRoomModel({
required super.chatId,
    required super.otherUserId,
    required super.otherUserName,
    required super.otherUserAvatarUrl,
    required super.lastMessage,
    required super.lastMessageTime,
    super.unreadCount = 0,
  });
}