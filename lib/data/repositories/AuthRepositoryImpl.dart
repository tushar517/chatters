import 'package:chat_app/commonutils/api_request/user_request.dart';
import 'package:chat_app/data/data_sources/Auth_remote_data_source.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';
import 'package:chat_app/commonutils/Result.dart';
import 'package:chat_app/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Result> logIn({required UserRequest user})async {
    var response = await remoteDataSource.logIn(user: user);
    if(response.status){
      return Success(response);
    }else{
      return Error(response.description);
    }
  }

  @override
  Future<Result> signUp({required UserRequest user}) async{
    var response = await remoteDataSource.signUp(user: user);
    if(response.status){
      return Success(response);
    }else{
      return Error(response.description);
    }
  }

}