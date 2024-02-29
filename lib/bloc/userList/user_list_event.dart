part of 'user_list_bloc.dart';

abstract class UserListEvent {}

class InitUserScreen extends UserListEvent{
  final String userName;

  InitUserScreen(this.userName);
}

class StompAddUser extends UserListEvent{
  final User user;

  StompAddUser({required this.user});
}
class StompRemoveUser extends UserListEvent{
  final User user;

  StompRemoveUser({required this.user});

}

class LogoutEvent extends UserListEvent{

}