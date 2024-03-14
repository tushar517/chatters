import 'package:chat_app/commonutils/http_service.dart';
import 'package:chat_app/data/models/ApiResponse.dart';
import 'package:chat_app/data/models/chat_message.dart';
import 'package:chat_app/data/models/user.dart';

abstract interface class ListRemoteDataSourceRepository {
  Future<List<User>> getConnectedUserList();

  Future<List<ChatMessage>> getChatList(String senderId, String recipientId);
}

class ListRemoteDataSourceImpl implements ListRemoteDataSourceRepository {
  @override
  Future<List<ChatMessage>> getChatList(
      String senderId, String recipientId) async {
    var response = await dio.get(
      "messages/$senderId/$recipientId",
    );
    if (response.statusCode == 200) {
      print(response.data);
      List<ChatMessage> _model =
          (response.data as List).map((e) => ChatMessage.fromJson(e)).toList();
      if (_model.isNotEmpty) {
        return _model;
      } else {
        return <ChatMessage>[];
      }
    }
    return <ChatMessage>[];
  }

  @override
  Future<List<User>> getConnectedUserList() async {
    var response = await dio.get("users");
    if (response.statusCode == 200) {
      print(response.data);
      List<User> model =
          (response.data as List).map((e) => User.fromJson(e)).toList();
      if (model.isNotEmpty) {
        return model;
      } else {
        return <User>[];
      }
    }
    return <User>[];
  }
}
