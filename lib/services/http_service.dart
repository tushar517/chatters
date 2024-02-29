import 'dart:convert';
import 'dart:io';

import 'package:chat_app/models/ApiResponse.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/user.dart';
import 'package:dio/dio.dart';

String baseUrl ="https://chat-services.onrender.com/";
// String baseUrl ="http://localhost:8088/";

final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
  )
);
void main(){
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    request: true,
    responseBody: true,
  ));
}
class ApiService {
  Future<List<User>> getConnectedUsers() async {
    try {
      var response = await dio.get("users");
      if (response.statusCode == 200) {
        print(response.data);
        List<User> _model = (response.data as List).map((e) => User.fromJson(e)).toList();
        if(_model.isNotEmpty) {
          return _model;
        }else{
          return <User>[];
        }
      }
    } catch (ex) {
      print("error ${ex.toString()}");
    }
    return <User>[];
  }

  Future<List<ChatMessage>> getChat(
      String senderId, String recipientId) async {
    try {
      var response = await dio.get(
          "messages/$senderId/$recipientId",
      );
      if (response.statusCode == 200) {
        print(response.data);
        List<ChatMessage> _model = (response.data as List).map((e) => ChatMessage.fromJson(e)).toList();
        if(_model.isNotEmpty){
          return _model;
        }else{
          return <ChatMessage>[];
        }
      }
    } catch (ex) {
        print("error ${ex.toString()}");
    }
    return <ChatMessage>[];
  }

  Future<ApiResponse> signUpUser(User user) async {
    try {
      var response = await dio.post(
        "user/createUser",
        data: json.encode(user.toJson())
      );
      print(json.encode(user.toJson()));
      if (response.statusCode == 200) {
        print(response.data);
        return ApiResponse.fromJson(response.data);
      }
    } catch (ex) {
      print(ex.toString());
    }
    return ApiResponse(status: false, description: "Something went wrong");
  }

  Future<ApiResponse> loginUser(User user) async {
    try {
      var response = await dio.post(
          "user/loginUser",
          data: json.encode(user.toJson())
      );
      print(json.encode(user.toJson()));
      if (response.statusCode == 200) {
        print(response.data);
        return ApiResponse.fromJson(response.data);
      }
    } catch (ex) {
      print(ex.toString());
    }
    return ApiResponse(status: false, description: "Something went wrong");
  }
}
