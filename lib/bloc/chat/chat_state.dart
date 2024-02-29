part of 'chat_bloc.dart';

class ChatState {
  String senderUserName;
  String receiverUserName;
  List<ChatMessage> chatList;
  Map<String,List<ChatMessage>> chatMap;
  String messageToSend;
  Result chatApi;

  ChatState({
    this.chatList = const [],
    this.messageToSend = "",
    this.chatApi = const Empty(),
    this.receiverUserName ="",
    this.senderUserName = "",
    this.chatMap = const <String,List<ChatMessage>>{}
  });

  ChatState copyWith({
    String? messageToSend,
    List<ChatMessage>? chatList,
    Result? chatApi,
    String? senderUserName,
    String? receiverUserName,
    Map<String,List<ChatMessage>>? chatMap
  }) {
    return ChatState(
      messageToSend: messageToSend??this.messageToSend,
      chatList: chatList??this.chatList,
      chatApi: chatApi??this.chatApi,
      senderUserName: senderUserName??this.senderUserName,
      receiverUserName: receiverUserName??this.receiverUserName,
      chatMap: chatMap??this.chatMap
    );
  }
}
