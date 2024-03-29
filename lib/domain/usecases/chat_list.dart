import 'package:chat_app/commonutils/use_case.dart';
import 'package:chat_app/commonutils/api_request/ChatListRequest.dart';
import 'package:chat_app/commonutils/Result.dart';
import 'package:chat_app/domain/repository/ListRepository.dart';

class ChatListUseCase implements UseCase<ChatListRequest>{
  final ListRepository _listRepository;

  ChatListUseCase(this._listRepository);
  @override
  Future<Result> call(ChatListRequest request) async{
    return await _listRepository.getChatList(request.senderId, request.recipientId);
  }
}