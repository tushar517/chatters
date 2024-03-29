part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class FirstNameChange extends SignUpEvent{
  final String firstName;

  FirstNameChange({required this.firstName});
}

class LastNameChange extends SignUpEvent{
  final String lastName;

  LastNameChange({required this.lastName});
}

class UserNameChange extends SignUpEvent{
  final String userName;

  UserNameChange({required this.userName});
}

class PasswordChange extends SignUpEvent{
  final String password;

  PasswordChange({required this.password});
}

class CnfPasswordChange extends SignUpEvent{
  final String cnfPassword;

  CnfPasswordChange({required this.cnfPassword});
}

class SignUpRequest extends SignUpEvent{
  final UserRequest user;
  SignUpRequest({required this.user});
}

class GenderChange extends SignUpEvent{
  final String gender;
  GenderChange({required this.gender});
}


