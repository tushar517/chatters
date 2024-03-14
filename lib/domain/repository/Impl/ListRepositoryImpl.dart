import 'package:chat_app/data/List_remote_data_source.dart';
import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/domain/repository/ListRepository.dart';

class ListRepositoryImpl implements ListRepository{
  final ListRemoteDataSourceRepository listRemoteDataSourceRepository;
  ListRepositoryImpl(this.listRemoteDataSourceRepository);
  @override
  Future<Result> getChatList(String senderId, String recipientId)async {
    try{
      var response = await listRemoteDataSourceRepository.getChatList(
          senderId, recipientId);
      return Success(response);
    }catch(ex){
      return Error(ex.toString());
    }
  }

  @override
  Future<Result> getConnectedUserList()async {
    try{
      var response =
          await listRemoteDataSourceRepository.getConnectedUserList();
      return Success(response);
    }catch(ex){
    return Error(ex.toString());
    }
  }
}