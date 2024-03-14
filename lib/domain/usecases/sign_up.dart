import 'package:chat_app/commonutils/use_case.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';
import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/user.dart';

class SignUp implements UseCase<User>{
  final AuthRepository authRepository;
  const SignUp(this.authRepository);
  @override
  Future<Result> call(User user) async{
    return await authRepository.signUp(user: user);
  }
}