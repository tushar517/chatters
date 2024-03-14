import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User(
      {required this.userName,
      this.fullName = "",
      this.status = false,
      this.password = "",
      this.gender = "Male",
      this.lastSeen,
      this.lastSeenTime = ""});

  String userName;
  String fullName;
  bool status;
  String password;
  String gender;
  DateTime? lastSeen;
  String lastSeenTime;

  factory User.fromJson(Map<String, dynamic> json) {
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

    return User(
        userName: json["userName"],
        fullName: json["fullName"],
        status: json["status"],
        password: json["password"],
        gender: json["gender"],
        lastSeen: timeStamp,
        lastSeenTime: lastSeen);
  }

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "fullName": fullName,
        "status": status,
        "password": password,
        "gender": gender,
        "lastSeen": lastSeen ?? DateTime.now().toIso8601String()
      };

  @override
  String toString() {
    return 'User{userName: $userName, fullName: $fullName, status: $status, password: $password, gender: $gender, lastSeen: $lastSeen}';
  }
}
