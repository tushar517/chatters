part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class UserNameChangeEvent extends LoginEvent{
  final String userName;
  UserNameChangeEvent({required this.userName});
}
class UserPasswordChangeEvent extends LoginEvent{
  final String password;
  UserPasswordChangeEvent({required this.password});
}
class LoginUserRequest extends LoginEvent{
  final UserRequest user;
  LoginUserRequest({required this.user});
}
