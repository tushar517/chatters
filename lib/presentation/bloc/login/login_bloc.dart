import 'package:chat_app/models/ApiResponse.dart';
import 'package:chat_app/models/Result.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/http_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginState()) {

    on<UserPasswordChangeEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
      if (event.password.isEmpty) {
        emit(
          state.copyWith(
            passwordError: 'password can\'t be empty',
            isPasswordError: true,
          ),
        );
      }else if (event.password.length < 6) {
        emit(
        state.copyWith(
          passwordError: 'Password must have least 6 digit',
          isPasswordError: true,
        ),
      );
    } else if (!RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&*()<>.]).*$')
          .hasMatch(event.password)) {
        emit(
          state.copyWith(
            passwordError:
            'Password must have least one special character, alphabet and number',
            isPasswordError: true,
          ),
        );
      }
      else{
        emit(state.copyWith(isPasswordError: false,passwordError: ""));
      }
    });

    on<UserNameChangeEvent>((event,emit){
      emit(state.copyWith(username: event.userName));
      if (event.userName.isEmpty) {
        emit(
          state.copyWith(
            nameError: 'User name can\'t be empty',
            isUserNameError: true,
          ),
        );
      } else if (isAlpha(event.userName) || isNumeric(event.userName)) {
        emit(
          state.copyWith(
            nameError:
            'Username need to have least one number and alphabet',
            isUserNameError: true,
          ),
        );
      } else if (!isAlphanumeric(event.userName)) {
        emit(
          state.copyWith(
            nameError: 'Username can\'t contain special character',
            isUserNameError: true,
          ),
        );
      }else{
        emit(state.copyWith(isUserNameError: false,nameError: ""));
      }
    });

    on<LoginUserRequest>((event, emit) async {
      emit(state.copyWith(loginApi: const Loading()));
      try {
        ApiResponse response = await ApiService().loginUser(event.user);
        emit(
          state.copyWith(
            loginApi: Success<ApiResponse>(response),
          ),
        );
      } catch (exception) {
        emit(
          state.copyWith(
            loginApi: const Error("something went wrong"),
          ),
        );
      }
      emit(
        state.copyWith(
          loginApi: const Empty(),
        ),
      );
    });
  }

  @override
  void onChange(Change<LoginState> change) {

    super.onChange(change);
    print("Login Bloc - $change");
  }
}
