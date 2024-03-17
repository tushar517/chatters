import 'package:chat_app/data/models/ApiResponse.dart';
import 'package:chat_app/data/models/Result.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/presentation/bloc/signup/sign_up_bloc.dart';
import 'package:chat_app/presentation/common_widgets/ProgressIndicator.dart';
import 'package:chat_app/presentation/common_widgets/custom_snackbar.dart';
import 'package:chat_app/presentation/common_widgets/custom_values.dart';
import 'package:chat_app/commonutils/router/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var bloc = context.read<SignUpBloc>();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (BuildContext context, SignUpState state) {
            Result result = state.signUpApi as Result;
            if (result is Success<ApiResponse>) {
              showSnackBar(context, result.data.description, true);
              if (result.data.status) {
                screenRouter.goNamed("login");
              }
            }
            if (result is Error) {
              showSnackBar(context, result.errorMessage, false);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Image(
                        image: const AssetImage('assets/signup_img.png'),
                        fit: BoxFit.fill,
                        width: width / 1.25,
                        height: height / 3.5,
                      ),
                      Container(
                        width: width,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/form_bg.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: const Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Color(0xffEFEFEF),
                                  fontSize: 35,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                              label: "First Name",
                                              prefixIcon:
                                                  'assets/username_icon.png',
                                              onValueChange: (value) {
                                                bloc.add(FirstNameChange(
                                                    firstName: value));
                                              },
                                              isObscure: false,
                                            ),
                                            if (state.isFirstNameError &&
                                                state.firstNameError.isNotEmpty)
                                              Text(
                                                state.firstNameError,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                              label: "Last Name",
                                              prefixIcon:
                                                  'assets/username_icon.png',
                                              onValueChange: (value) {
                                                bloc.add(LastNameChange(
                                                    lastName: value));
                                              },
                                              isObscure: false,
                                            ),
                                            if (state.isLastNameError &&
                                                state.lastNameError.isNotEmpty)
                                              Text(
                                                state.lastNameError,
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    label: "Username",
                                    prefixIcon: 'assets/username_icon.png',
                                    onValueChange: (value) {
                                      bloc.add(UserNameChange(userName: value));
                                    },
                                    isObscure: false,
                                  ),
                                  if (state.isUserNameError &&
                                      state.userNameError.isNotEmpty)
                                    Text(
                                      state.userNameError,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    label: "Password",
                                    prefixIcon: 'assets/password_icon.png',
                                    onValueChange: (value) {
                                      bloc.add(PasswordChange(password: value));
                                    },
                                    isObscure: true,
                                    isPassword: true,
                                  ),
                                  if (state.isPasswordError &&
                                      state.passwordError.isNotEmpty)
                                    Text(
                                      state.passwordError,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextField(
                                    label: "Confirm Password",
                                    prefixIcon: 'assets/password_icon.png',
                                    onValueChange: (value) {
                                      bloc.add(CnfPasswordChange(
                                          cnfPassword: value));
                                    },
                                    isObscure: true,
                                    isPassword: true,
                                  ),
                                  if (state.isCnfpasswordError &&
                                      state.cnfpasswordError.isNotEmpty)
                                    Text(
                                      state.cnfpasswordError,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                        color: Color(0xffA4A4A4),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    decoration: textFieldDecoration,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        items: <String>['Male', 'Female']
                                            .map(
                                              (String val) =>
                                                  DropdownMenuItem<String>(
                                                value: val,
                                                child: Text(
                                                  val,
                                                  style: const TextStyle(
                                                      color: Colors.white60),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (String? value) {
                                          bloc.add(GenderChange(
                                              gender: value ?? ''));
                                        },
                                        hint: const Text(
                                          "Select your Gender",
                                          style: TextStyle(
                                            color: Color(0xffA4A4A4),
                                          ),
                                        ),
                                        isExpanded: true,
                                        value: state.gender == ''
                                            ? null
                                            : state.gender,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10),
                                        dropdownColor: Color(0xff5C5062),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomButton(
                                    width: width,
                                    onPress: () {
                                      bloc.add(SignUpRequest(
                                        user: User(
                                            userName: state.userName,
                                            fullName:
                                                "${state.firstName} ${state.lastName}",
                                            status: false,
                                            password: state.password,
                                            gender: state.gender),
                                      ));
                                    },
                                    btntext: "Sign up",
                                    isEnable: !state.isLastNameError &&
                                        !state.isFirstNameError &&
                                        !state.isPasswordError &&
                                        !state.isUserNameError &&
                                        !state.isCnfpasswordError &&
                                        state.gender.isNotEmpty,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage('assets/divider_left.png'),
                                  width: 55,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Already Have An Account?",
                                  style: TextStyle(
                                      color: Color(0xffA4A4A4),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Image(
                                  image: AssetImage('assets/divider_right.png'),
                                  width: 55,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width,
                              alignment: AlignmentDirectional.center,
                              child: GestureDetector(
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Color(0xffEFEFEF),
                                    fontSize: 25,
                                  ),
                                ),
                                onTap: () {
                                  screenRouter.goNamed("login");
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Image(
                              image: const AssetImage(
                                'assets/book.png',
                              ),
                              alignment: Alignment.bottomRight,
                              width: width,
                              height: 100,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if(state.signUpApi is Loading)
                    const CustomProgressBar()
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
