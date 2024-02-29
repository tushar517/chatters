import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Result.dart';
import '../../models/chat_message.dart';
import '../../services/http_service.dart';
import 'package:collection/collection.dart';
part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<AddSenderReceiverName>((event, emit) {
      emit(state.copyWith(
          senderUserName: event.senderName,
          receiverUserName: event.recevierName));
    });

    on<ChatLoadEvent>((event, emit) async {
      emit(state.copyWith(chatApi: const Loading()));
      try {
        List<ChatMessage> chats = await ApiService()
            .getChat(state.senderUserName, state.receiverUserName);
        Map<String,List<ChatMessage>> chatMap = groupBy(chats, (ChatMessage p0) => p0.messageDay);
        emit(
          state.copyWith(
            chatList: List.from(state.chatList)..addAll(chats),
            chatMap: chatMap,
            chatApi: const Success("Chat Fetched Successfully")
          ),
        );
      } catch (ex) {
        emit(
          state.copyWith(
              chatApi: Success(ex.toString())
          ),
        );
        print("screen ${ex.toString()}");
      }
    });

    on<ChatReceiveEvent>((event, emit) {
      Map<String,List<ChatMessage>> chatMap = state.chatMap;
      chatMap.update(event.chat.messageDay, (list) => [...list, event.chat], ifAbsent: () => [event.chat]);
      emit(
        state.copyWith(
          chatList: List.from(state.chatList)..add(event.chat),
          chatMap: chatMap,
          messageToSend: "",
        ),
      );
    });

    on<MessageTypingEvent>((event, emit) {
      emit(state.copyWith(messageToSend: event.message));
    });
  }
}
