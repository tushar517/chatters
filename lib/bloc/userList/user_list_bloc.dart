import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/Result.dart';
import '../../models/user.dart';
import '../../services/http_service.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc() : super(UserListState()) {
    on<InitUserScreen>((event, emit) async {
      emit(state.copyWith(userApi: const Loading()));
      try {
        var users = await ApiService().getConnectedUsers();
        print("difference between ${DateTime.now().difference(users[0].lastSeen??DateTime.now()).inHours}");
        emit(
          state.copyWith(
              userApi: Success<List<User>>(users),
              connectedUserList: users
                  .where((element) =>
                      (element.status && element.userName != event.userName))
                  .toList(),
              disconnectedUserList:
                  users.where((element) => !element.status).toList()),
        );
      } catch (ex) {
        emit(state.copyWith(userApi: Error(ex.toString())));
      }
      emit(state.copyWith(userApi: const Empty()));
    });

    on<StompAddUser>((event, emit) {
      List<User> list = List.from(state.connectedUserList);
      List<User> disconnectedList = List.from(state.disconnectedUserList);
      int index =
          list.indexWhere((element) => element.userName == event.user.userName);
      int disconnectedIndex = disconnectedList
          .indexWhere((element) => element.userName == event.user.userName);
      if (index < 0) {
        list.add(event.user);
      }
      if (disconnectedIndex >= 0) {
        disconnectedList.remove(disconnectedList[disconnectedIndex]);
      }
      emit(state.copyWith(
          connectedUserList: list, disconnectedUserList: disconnectedList));
    });

    on<StompRemoveUser>((event, emit) {
      List<User> connectedList = List.from(state.connectedUserList);
      List<User> disconnectedList = List.from(state.disconnectedUserList);
      int index = connectedList
          .indexWhere((element) => element.userName == event.user.userName);
      int disconnectedIndex = disconnectedList
          .indexWhere((element) => element.userName == event.user.userName);
      if (disconnectedIndex < 0) {
        disconnectedList.add(event.user);
      }
      if (index >= 0) {
        connectedList.remove(connectedList[index]);
      }
      emit(
        state.copyWith(
          disconnectedUserList: disconnectedList,
          connectedUserList: connectedList,
        ),
      );
    });
  }
}
