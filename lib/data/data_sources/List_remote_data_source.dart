import 'package:chat_app/commonutils/http_service.dart';
import 'package:chat_app/data/models/api_response_model.dart';
import 'package:chat_app/data/models/chat_message_model.dart';
import 'package:chat_app/data/models/user_model.dart';

abstract interface class ListRemoteDataSourceRepository {
  Future<List<UserModel>> getConnectedUserList();

  Future<List<ChatMessageModel>> getChatList(String senderId, String recipientId);
}

class ListRemoteDataSourceImpl implements ListRemoteDataSourceRepository {
  @override
  Future<List<ChatMessageModel>> getChatList(
      String senderId, String recipientId) async {
    var response = await dio.get(
      "messages/$senderId/$recipientId",
    );
    if (response.statusCode == 200) {
      print(response.data);
      List<ChatMessageModel> model =
          (response.data as List).map((e) => ChatMessageModel.fromJson(e)).toList();
      if (model.isNotEmpty) {
        return model;
      } else {
        return <ChatMessageModel>[];
      }
    }
    return <ChatMessageModel>[];
  }

  @override
  Future<List<UserModel>> getConnectedUserList() async {
    var response = await dio.get("users");
    if (response.statusCode == 200) {
      print(response.data);
      List<UserModel> model =
          (response.data as List).map((e) => UserModel.fromJson(e)).toList();
      if (model.isNotEmpty) {
        return model;
      } else {
        return <UserModel>[];
      }
    }
    return <UserModel>[];
  }
}
