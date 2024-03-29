import 'package:chat_app/commonutils/api_request/user_request.dart';
import 'package:chat_app/commonutils/Result.dart';

abstract interface class AuthRepository {
  Future<Result> signUp({required UserRequest user});

  Future<Result> logIn({required UserRequest user});
}
