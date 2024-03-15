import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<ChatMessage> chatFromJson(String str) => List<ChatMessage>.from(
    json.decode(str).map((x) => ChatMessage.fromJson(x)));

String chatToJson(List<ChatMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatMessage {
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

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
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
    return ChatMessage(
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
