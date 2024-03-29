import 'package:chat_app/commonutils/api_request/user_request.dart';
import 'package:chat_app/commonutils/use_case.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';
import 'package:chat_app/commonutils/Result.dart';

class SignUp implements UseCase<UserRequest>{
  final AuthRepository authRepository;
  const SignUp(this.authRepository);
  @override
  Future<Result> call(UserRequest user) async{
    return await authRepository.signUp(user: user);
  }
}