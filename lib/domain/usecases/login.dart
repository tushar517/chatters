import 'package:chat_app/commonutils/api_request/user_request.dart';
import 'package:chat_app/commonutils/use_case.dart';
import 'package:chat_app/commonutils/Result.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';

class LoginUseCase implements UseCase<UserRequest>{
  final AuthRepository authRepository;
  const LoginUseCase(this.authRepository);
  @override
  Future<Result> call(UserRequest user) async{
    return await authRepository.logIn(user: user);
  }
}