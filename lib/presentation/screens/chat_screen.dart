import 'dart:convert';
import 'dart:core';
import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/chat_message.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/presentation/common_widgets/custom_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../commonutils/StompClient/stomp_client.dart';

class ChatScreen extends StatelessWidget {
  final String senderNickname;
  final User receiverUser;
  final String profileImg;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _chatScrollController = ScrollController();
  final TextEditingController messageTextController = TextEditingController();

  ChatScreen(
      {super.key,
        required this.senderNickname,
        required this.receiverUser,
        required this.profileImg});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ChatBloc>()
      ..add(AddSenderReceiverName(
          senderName: senderNickname, recevierName: receiverUser.userName))
      ..add(ChatLoadEvent());
    subscribeChat(bloc);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {},
          builder: (parentContext, state) {
            return Column(
              children: [
                Container(
                  color: Color(0xff1F1F1F),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(37)),
                            image: DecorationImage(
                                image: AssetImage(profileImg),
                                fit: BoxFit.fill)),
                        height: 77,
                        width: 67,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            receiverUser.fullName,
                            style: const TextStyle(
                                color: Color(0xffC8C8C8),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          if (receiverUser.status)
                            const Row(
                              children: [
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Color(0xff00FF85),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Active",
                                  style: TextStyle(
                                      color: Color(0xff00FF85),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (state.chatApi is Loading)
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Please Wait...\nLoading Chat",textAlign: TextAlign.center,style: TextStyle(color:Color(0xffC8C8C8)),)
                        ],
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                if (state.chatApi is Success)
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.chatMap.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var key = state.chatMap.keys.elementAt(index);
                          var list = state.chatMap[key] ?? [];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  key,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff4D4C4E), fontSize: 18),
                                ),
                              ),
                              Flexible(
                                child: ListView.builder(
                                  controller: _chatScrollController,
                                  itemCount: list.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if (list[index].senderId ==
                                        senderNickname) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                gradient: purpleGradient,
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15))),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 20),
                                            margin: EdgeInsets.only(left: 20),
                                            child: Text(
                                              list[index].content,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(
                                                            37)),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            profileImg),
                                                        fit: BoxFit.fill)),
                                                height: 50,
                                                width: 50,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      gradient: greyGradient,
                                                      borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              15))),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12,
                                                      horizontal: 20),
                                                  margin: EdgeInsets.only(
                                                      right: 20),
                                                  child: Text(
                                                    list[index].content,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                if (state.chatApi is Success)
                  SizedBox(
                    height: 20,
                  ),
                if (state.chatApi is Success)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    color: Color(0xff1F1F1F),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff272626), width: 0.3),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                                color: Color(0xff272626)),
                            child: TextField(
                              onChanged: (value) {
                                bloc.add(
                                  MessageTypingEvent(message: value),
                                );
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: "Type Your Message",
                                hintStyle: TextStyle(color: Color(0xff4D4C4E)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10),
                              ),
                              controller: messageTextController,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            child: Image.asset('assets/send_message.png'),
                            onTap: () {
                              if (state.messageToSend.isNotEmpty) {
                                stompClient.send(
                                  destination: "/app/chat",
                                  body: json.encode(
                                    {
                                      "senderId": state.senderUserName,
                                      "recipientId": state.receiverUserName,
                                      "content": state.messageToSend
                                    },
                                  ),
                                );
                              }
                            })
                      ],
                    ),
                  )
              ],
            );
          },
        ),
        backgroundColor: const Color(0xff121111),
      ),
    );
  }

  void subscribeChat(ChatBloc bloc) {
    stompClient.subscribe(
        destination: "/user/messages",
        callback: (StompFrame frame) {
          try {
            ChatMessage chat = ChatMessage.fromJson(json.decode(frame.body!));
            if ((chat.senderId == senderNickname &&
                chat.recipientId == receiverUser.userName) ||
                (chat.senderId == receiverUser.userName &&
                    chat.recipientId == senderNickname)) {
              bloc.add(ChatReceiveEvent(chat: chat));
              if (chat.senderId == senderNickname) {
                _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut);
                _chatScrollController.animateTo(
                    _chatScrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut);
                messageTextController.text = "";
              }
            }
          } catch (ex) {
            print("stomp error ${ex.toString()}");
          }
        });
  }
}
