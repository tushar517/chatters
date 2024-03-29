class ChatMessage{
  ChatMessage(
      {required this.id,
        required this.timeStamp,
        required this.chatId,
        required this.content,
        required this.recipientId,
        required this.senderId,
        this.messageDay = "",
        this.messageTime = "",
      });

  int id;
  String chatId;
  String senderId;
  String recipientId;
  String content;
  DateTime timeStamp;
  String messageDay;
  String messageTime;
}