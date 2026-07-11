import 'package:equatable/equatable.dart';

class ChatRoomEntity extends Equatable {
  final String chatId;
  final String otherUserId;
  final String otherUserName;
  final String otherUserAvatarUrl;
  final String lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;

  const ChatRoomEntity({
    required this.chatId,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserAvatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [
        chatId,
        otherUserId,
        otherUserName,
        otherUserAvatarUrl,
        lastMessage,
        lastMessageTime,
        unreadCount,
      ];
}