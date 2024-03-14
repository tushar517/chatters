import 'package:chat_app/commonutils/use_case.dart';
import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/domain/repository/AuthRepository.dart';

class LoginUseCase implements UseCase<User>{
  final AuthRepository authRepository;
  const LoginUseCase(this.authRepository);
  @override
  Future<Result> call(User user) async{
    return await authRepository.logIn(user: user);
  }
}