part of 'sign_up_bloc.dart';

class SignUpState {
  final String firstName;
  final bool isFirstNameError;
  final String firstNameError;
  final String lastName;
  final bool isLastNameError;
  final String lastNameError;
  final String userName;
  final bool isUserNameError;
  final String userNameError;
  final String password;
  final bool isPasswordError;
  final String passwordError;
  final String cnfpassword;
  final bool isCnfpasswordError;
  final String cnfpasswordError;
  final Result signUpApi;
  final String gender;

  SignUpState(
      {this.firstName = '',
      this.lastName = '',
      this.userName = '',
      this.password = '',
      this.cnfpassword = '',
      this.isFirstNameError = true,
      this.firstNameError = '',
      this.isLastNameError = true,
      this.lastNameError = '',
      this.isUserNameError = true,
      this.userNameError = '',
      this.isPasswordError = true,
      this.passwordError = '',
      this.isCnfpasswordError = true,
      this.cnfpasswordError = '',
      this.signUpApi = const Empty(),
      this.gender = ''});

  SignUpState copyWith({
    String? firstName,
    String? lastName,
    String? userName,
    String? password,
    String? cnfpassword,
    bool? isFirstNameError,
    String? firstNameError,
    bool? isLastNameError,
    String? lastNameError,
    bool? isUserNameError,
    String? userNameError,
    bool? isPasswordError,
    String? passwordError,
    bool? isCnfpasswordError,
    String? cnfpasswordError,
    Result? signUpApi,
    String? gender,
  }) {
    return SignUpState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        cnfpassword: cnfpassword ?? this.cnfpassword,
        isFirstNameError: isFirstNameError ?? this.isFirstNameError,
        isLastNameError: isLastNameError ?? this.isLastNameError,
        isUserNameError: isUserNameError ?? this.isUserNameError,
        isPasswordError: isPasswordError ?? this.isPasswordError,
        isCnfpasswordError: isCnfpasswordError ?? this.isCnfpasswordError,
        firstNameError: firstNameError ?? this.firstNameError,
        lastNameError: lastNameError ?? this.lastNameError,
        userNameError: userNameError ?? this.userNameError,
        passwordError: passwordError ?? this.passwordError,
        cnfpasswordError: cnfpasswordError ?? this.cnfpasswordError,
        signUpApi: signUpApi ?? this.signUpApi,
        gender: gender ?? this.gender);
  }

  @override
  String toString() {
    return 'SignUpState{firstName: $firstName, isFirstNameError: $isFirstNameError, firstNameError: $firstNameError, lastName: $lastName, isLastNameError: $isLastNameError, lastNameError: $lastNameError, userName: $userName, isUserNameError: $isUserNameError, userNameError: $userNameError, password: $password, isPasswordError: $isPasswordError, passwordError: $passwordError, cnfpassword: $cnfpassword, isCnfpasswordError: $isCnfpasswordError, cnfpasswordError: $cnfpasswordError, signUpApi: $signUpApi, gender: $gender}';
  }
}
