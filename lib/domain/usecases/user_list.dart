import 'package:chat_app/commonutils/use_case.dart';
import 'package:chat_app/commonutils/Result.dart';
import 'package:chat_app/domain/repository/ListRepository.dart';

class UserListUseCase implements UseCase{
  final ListRepository _listRepository;

  UserListUseCase(this._listRepository);

  @override
  Future<Result> call(params) async{
    return await _listRepository.getConnectedUserList();
  }

}