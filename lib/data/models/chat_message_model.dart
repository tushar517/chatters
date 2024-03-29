import 'dart:convert';

import 'package:chat_app/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<ChatMessageModel> chatFromJson(String str) => List<ChatMessageModel>.from(
    json.decode(str).map((x) => ChatMessageModel.fromJson(x)));

class ChatMessageModel extends ChatMessage{
  ChatMessageModel(
      {required super.id,
      required super.timeStamp,
      required super.chatId,
      required super.content,
      required super.recipientId,
      required super.senderId,
        super.messageDay = "",
        super.messageTime = "",
      });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    DateTime timeStamp;
    String messageTime;
    String messageDay;
    if (json["timeStamp"] is String) {
      timeStamp = DateTime.parse(json["timeStamp"]);
    } else {
      timeStamp = DateTime.fromMillisecondsSinceEpoch(json["timeStamp"]);
    }

    if (DateUtils.isSameDay(timeStamp, DateTime.now())) {
      messageDay = "Today";
    } else if (DateUtils.isSameDay(
        timeStamp.add(const Duration(days: 1)), DateTime.now())) {
      messageDay = "Yesterday";
    } else {
      messageDay = DateFormat("dd/MM/yyyy").format(timeStamp);
    }

    messageTime = DateFormat.jm().format(timeStamp);
    return ChatMessageModel(
        id: json["id"],
        chatId: json["chatId"],
        senderId: json["senderId"],
        recipientId: json["recipientId"],
        content: json["content"],
        timeStamp: timeStamp,
        messageTime: messageTime,
      messageDay: messageDay

    );
  }

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "recipientId": recipientId,
        "content": content,
        "timeStamp": timeStamp,
      };

  @override
  String toString() {
    return 'ChatMessage{id: $id, chatId: $chatId, senderId: $senderId, recipientId: $recipientId, content: $content, timeStamp: $timeStamp}';
  }
}
