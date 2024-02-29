part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class AddSenderReceiverName extends ChatEvent{
  final String senderName;
  final String recevierName;

  AddSenderReceiverName({required this.senderName, required this.recevierName});

}

class MessageTypingEvent extends ChatEvent{
  final String message;

  MessageTypingEvent({required this.message});

}

class ChatLoadEvent extends ChatEvent{

  ChatLoadEvent();
}

class ChatReceiveEvent extends ChatEvent{
  final ChatMessage chat;

  ChatReceiveEvent({required this.chat});
}