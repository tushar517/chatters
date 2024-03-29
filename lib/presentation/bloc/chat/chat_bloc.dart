import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/commonutils/http_service.dart';
import 'package:chat_app/commonutils/api_request/ChatListRequest.dart';
import 'package:chat_app/domain/usecases/chat_list.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';

import 'package:chat_app/commonutils/Result.dart';
import 'package:chat_app/data/models/chat_message_model.dart';
part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatListUseCase _chatListUseCase;
  ChatBloc({required ChatListUseCase chatListUseCase}) :_chatListUseCase = chatListUseCase, super(ChatState()) {
    on<AddSenderReceiverName>((event, emit) {
      emit(state.copyWith(
          senderUserName: event.senderName,
          receiverUserName: event.recevierName));
    });

    on<ChatLoadEvent>((event, emit) async {
      emit(state.copyWith(chatApi: const Loading()));
      try {
        var chats = await _chatListUseCase(ChatListRequest(recipientId: state.receiverUserName, senderId: state.senderUserName));
        if(chats is Success<List<ChatMessageModel>>) {
          Map<String, List<ChatMessageModel>> chatMap =
              groupBy(chats.data, (ChatMessageModel p0) => p0.messageDay);
          emit(
            state.copyWith(
                chatList: List.from(state.chatList)..addAll(chats.data),
                chatMap: chatMap,
                chatApi: const Success("Chat Fetched Successfully")),
          );
        }else{
          emit(
            state.copyWith(
                chatList: [],
                chatMap: {},
                chatApi: const Error("Something went wrong")),
          );
        }
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
      Map<String,List<ChatMessageModel>> chatMap = state.chatMap;
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
