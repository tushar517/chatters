import 'package:chat_app/data/Auth_remote_data_source.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';
import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/user.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Result> logIn({required User user})async {
    var response = await remoteDataSource.logIn(user: user);
    if(response.status){
      return Success(response);
    }else{
      return Error(response.description);
    }
  }

  @override
  Future<Result> signUp({required User user}) async{
    var response = await remoteDataSource.signUp(user: user);
    if(response.status){
      return Success(response);
    }else{
      return Error(response.description);
    }
  }

}