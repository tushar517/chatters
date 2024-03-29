import 'dart:convert';
import 'package:chat_app/domain/entities/User.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

class UserModel extends User {
  UserModel(
      {required super.userName,
        super.fullName = "",
        super.status = false,
        super.password = "",
        super.gender = "Male",
        super.lastSeen,
        super.lastSeenTime = ""});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    //yyyy-MM-dd'T'HH:mm:ss.SSSZ
    DateTime timeStamp;
    String lastSeen;
    if (json["lastSeen"] is String) {
      timeStamp = DateTime.parse(json["lastSeen"]);
    } else {
      timeStamp = DateTime.fromMillisecondsSinceEpoch(json["lastSeen"]);
    }

    if (DateUtils.isSameDay(timeStamp, DateTime.now())) {
      lastSeen = DateFormat.jm().format(timeStamp);
    } else if (DateUtils.isSameDay(
        timeStamp.add(const Duration(days: 1)), DateTime.now())) {
      lastSeen = "Yesterday";
    } else {
      lastSeen = DateFormat("dd/MM/yyyy").format(timeStamp);
    }

    return UserModel(
        userName: json["userName"],
        fullName: json["fullName"],
        status: json["status"],
        password: json["password"],
        gender: json["gender"],
        lastSeen: timeStamp,
        lastSeenTime: lastSeen);
  }

  @override
  String toString() {
    return 'User{userName: $userName, fullName: $fullName, status: $status, password: $password, gender: $gender, lastSeen: $lastSeen}';
  }
}
