import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/ApiResponse.dart';
import 'package:chat_app/models/Result.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/http_service.dart';
import 'package:meta/meta.dart';
import 'package:string_validator/string_validator.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState()) {
    on<FirstNameChange>((event, emit) {
      emit(
        state.copyWith(firstName: event.firstName),
      );
      if (event.firstName.isEmpty) {
        if (state.passwordError == 'Password should not contain first name') {
          emit(
            state.copyWith(
              passwordError: '',
              isPasswordError: false,
            ),
          );
        }
        emit(
          state.copyWith(
            firstNameError: 'First name can\'t be empty',
            isFirstNameError: true,
          ),
        );
      } else if (state.password.contains(event.firstName) &&
          state.password.isNotEmpty &&
          event.firstName.isNotEmpty) {
        emit(
          state.copyWith(
            passwordError: 'Password should not contain first name',
            isPasswordError: true,
          ),
        );
      } else if (!isAlpha(event.firstName)) {
        emit(
          state.copyWith(
            firstNameError: 'First name can contain alphabets only',
            isFirstNameError: true,
          ),
        );
      } else {
        if (state.passwordError == 'Password should not contain first name') {
          emit(
            state.copyWith(
              passwordError: '',
              isPasswordError: false,
            ),
          );
        }
        emit(
          state.copyWith(
            firstNameError: '',
            isFirstNameError: false,
          ),
        );
      }
    });

    on<LastNameChange>((event, emit) {
      emit(
        state.copyWith(lastName: event.lastName),
      );
      if (event.lastName.isEmpty) {
        emit(
          state.copyWith(
            lastNameError: 'Last name can\'t be empty',
            isLastNameError: true,
          ),
        );
      } else if (!RegExp(r'^[a-zA-Z\s]*$').hasMatch(event.lastName)) {
        emit(
          state.copyWith(
            lastNameError: 'Last name can contain alphabets only',
            isLastNameError: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            lastNameError: '',
            isLastNameError: false,
          ),
        );
      }
    });

    on<UserNameChange>((event, emit) {
      emit(
        state.copyWith(userName: event.userName),
      );
      if (event.userName.isEmpty) {
        emit(
          state.copyWith(
            userNameError: 'User name can\'t be empty',
            isUserNameError: true,
          ),
        );
      } else if (isAlpha(event.userName) || isNumeric(event.userName)) {
        emit(
          state.copyWith(
            userNameError:
                'Username need to have least one number and alphabet',
            isUserNameError: true,
          ),
        );
      } else if (!isAlphanumeric(event.userName)) {
        emit(
          state.copyWith(
            userNameError: 'Username can\'t contain special character',
            isUserNameError: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            userNameError: '',
            isUserNameError: false,
          ),
        );
      }
    });

    on<PasswordChange>((event, emit) {
      emit(
        state.copyWith(password: event.password),
      );
      if (event.password.isEmpty) {
        emit(
          state.copyWith(
            passwordError: 'password can\'t be empty',
            isPasswordError: true,
          ),
        );
      } else if (event.password.length < 6) {
        emit(
          state.copyWith(
            passwordError: 'Password must have least 6 digit',
            isPasswordError: true,
          ),
        );
      } else if (event.password.contains(state.firstName) &&
          state.firstName.isNotEmpty &&
          event.password.isNotEmpty) {
        emit(
          state.copyWith(
            passwordError: 'Password should not contain first name',
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
      } else {
        emit(
          state.copyWith(
            passwordError: '',
            isPasswordError: false,
          ),
        );
      }
    });

    on<CnfPasswordChange>((event, emit) {
      emit(
        state.copyWith(cnfpassword: event.cnfPassword),
      );
      if (event.cnfPassword.isEmpty) {
        emit(
          state.copyWith(
            cnfpasswordError: 'password can\'t be empty',
            isCnfpasswordError: true,
          ),
        );
      } else if (state.password != event.cnfPassword) {
        emit(
          state.copyWith(
            cnfpasswordError: 'Password and confirm password should match',
            isCnfpasswordError: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            cnfpasswordError: '',
            isCnfpasswordError: false,
          ),
        );
      }
    });

    on<SignUpRequest>((event, emit) async {
      emit(state.copyWith(signUpApi: const Loading()));
      try {
        ApiResponse response = await ApiService().signUpUser(event.user);
        emit(
          state.copyWith(
            signUpApi: Success<ApiResponse>(response),
          ),
        );
      } catch (exception) {
        emit(
          state.copyWith(
            signUpApi: const Error("something went wrong"),
          ),
        );
      }
      emit(
        state.copyWith(
          signUpApi: const Empty(),
        ),
      );
    });

    on<GenderChange>((event, emit) {
      emit(
        state.copyWith(
          gender: event.gender
        )
      );
    });
  }

  @override
  void onChange(Change<SignUpState> change) {
    super.onChange(change);
    print("Login Bloc - $change");
  }
}
