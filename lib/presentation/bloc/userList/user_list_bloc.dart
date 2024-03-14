import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/domain/usecases/user_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_list_event.dart';

part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final UserListUseCase _userListUseCase;

  UserListBloc({required UserListUseCase userListUseCase})
      : _userListUseCase = userListUseCase,
        super(UserListState()) {
    on<InitUserScreen>((event, emit) async {
      emit(state.copyWith(userApi: const Loading()));
      try {
        var users = await _userListUseCase("");
        List<User> connectedList = [];
        List<User> disConnectedList = [];
        if (users is Success<List<User>>) {
          connectedList = users.data
              .where((element) =>
                  (element.status && element.userName != event.userName))
              .toList();
          disConnectedList =
              users.data.where((element) => !element.status).toList();
        }
        emit(state.copyWith(
          userApi: users,
          connectedUserList: connectedList,
          disconnectedUserList: disConnectedList,
        ));
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
