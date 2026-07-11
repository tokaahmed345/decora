enum MessageType { text, image }

class MessagesEntity {
  final String id;
  final String senderId;
  final String text;
  final DateTime timeStamp;
  final bool isRead;
  final MessageType type;
  final String? imageUrl;

  MessagesEntity({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timeStamp,
    required this.isRead,
    this.type = MessageType.text,
    this.imageUrl,
  });
}