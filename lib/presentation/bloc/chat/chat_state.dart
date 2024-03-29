part of 'chat_bloc.dart';

class ChatState {
  String senderUserName;
  String receiverUserName;
  List<ChatMessageModel> chatList;
  Map<String,List<ChatMessageModel>> chatMap;
  String messageToSend;
  Result chatApi;

  ChatState({
    this.chatList = const [],
    this.messageToSend = "",
    this.chatApi = const Empty(),
    this.receiverUserName ="",
    this.senderUserName = "",
    this.chatMap = const <String,List<ChatMessageModel>>{}
  });

  ChatState copyWith({
    String? messageToSend,
    List<ChatMessageModel>? chatList,
    Result? chatApi,
    String? senderUserName,
    String? receiverUserName,
    Map<String,List<ChatMessageModel>>? chatMap
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
