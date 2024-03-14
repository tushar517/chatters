import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/user.dart';

abstract interface class AuthRepository {
  Future<Result> signUp({required User user});

  Future<Result> logIn({required User user});
}
