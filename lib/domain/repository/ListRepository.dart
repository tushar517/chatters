import 'package:chat_app/data/models/Result.dart';

abstract interface class ListRepository{
  Future<Result> getConnectedUserList();

  Future<Result> getChatList(String senderId, String recipientId);
}