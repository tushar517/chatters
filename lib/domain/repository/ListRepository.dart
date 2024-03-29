import 'package:chat_app/commonutils/Result.dart';

abstract interface class ListRepository{
  Future<Result> getConnectedUserList();

  Future<Result> getChatList(String senderId, String recipientId);
}