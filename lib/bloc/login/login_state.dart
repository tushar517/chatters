part of 'login_bloc.dart';

class LoginState {
  final String username;
  final String password;
  final bool isLoading;
  final bool isUserNameError;
  final bool isPasswordError;
  final String nameError;
  final String passwordError;
  final Result loginApi;

  LoginState(
      {this.username = '',
      this.password = '',
      this.isLoading = false,
      this.isUserNameError = true,
      this.isPasswordError = true,
      this.nameError = '',
      this.passwordError = '',
      this.loginApi = const Empty()});

  LoginState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isUserNameError,
    bool? isPasswordError,
    String? nameError,
    String? passwordError,
    Result? loginApi,
  }) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        isUserNameError: isUserNameError ?? this.isUserNameError,
        isPasswordError: isPasswordError ?? this.isPasswordError,
        nameError: nameError ?? this.nameError,
        passwordError: passwordError ?? this.passwordError,
        loginApi: loginApi ?? this.loginApi);
  }

  @override
  String toString() {
    return 'LoginState{username: $username, password: $password, isLoading: $isLoading, isUserNameError: $isUserNameError, isPasswordError: $isPasswordError, nameError: $nameError, passwordError: $passwordError, loginApi: $loginApi}';
  }
}
