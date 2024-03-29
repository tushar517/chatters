part of 'user_list_bloc.dart';

class UserListState {
  List<UserModel> connectedUserList;
  List<UserModel> disconnectedUserList;
  final List<String> maleImg = [
    'assets/male1.jpg',
    'assets/male2.jpg',
    'assets/male3.jpg',
    'assets/male4.jpg',
  ];
  final List<String> femaleImg = [
    'assets/female1.jpg',
    'assets/female2.jpg',
    'assets/female3.jpg',
    'assets/female4.jpg',
  ];
  final Result userApi;

  UserListState({
    this.connectedUserList = const [],
    this.disconnectedUserList = const [],
    this.userApi = const Empty(),
  });

  UserListState copyWith({List<UserModel>? connectedUserList,List<UserModel>? disconnectedUserList, Result? userApi}){
    return UserListState(
      connectedUserList: connectedUserList??this.connectedUserList,
        disconnectedUserList: disconnectedUserList??this.disconnectedUserList,
      userApi: userApi??this.userApi
    );
  }

  @override
  String toString() {
    return 'UserListState{connectedUserList: $connectedUserList,disconnectedUserList: $disconnectedUserList, maleImg: $maleImg, femaleImg: $femaleImg, userApi:$userApi}';
  }
}
