import 'dart:convert';
import 'package:chat_app/models/ApiResponse.dart';
import 'package:chat_app/models/Result.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/presentation/bloc/login/login_bloc.dart';
import 'package:chat_app/presentation/common_widgets/custom_button.dart';
import 'package:chat_app/presentation/common_widgets/custom_textfield.dart';
import 'package:chat_app/router/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/StompClient/stomp_client.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});


  @override
  Widget build(BuildContext context) {
    var bloc = context.read<LoginBloc>();
    var width = MediaQuery.of(context).size.width;
    stompClient.activate();

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
            Result result = state.loginApi as Result;
            if (result is Success<ApiResponse>) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result.data.description)));
              if (result.data.status) {
                stompClient.send(
                    destination: "/app/user/addUser",
                    body: jsonEncode({
                      "userName": state.username,
                    }));
                screenRouter.goNamed(
                  "connected_user",
                  pathParameters: {"nickName": state.username},
                );
              }
            }
            if (result is Error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(result.errorMessage)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Image(
                    image: const AssetImage('assets/login_img.png'),
                    fit: BoxFit.fill,
                    width: width / 1.25,
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
                            "Welcome Back!",
                            style: TextStyle(
                              color: Color(0xffEFEFEF),
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextField(
                                label: "Username",
                                prefixIcon: 'assets/username_icon.png',
                                onValueChange: (value) {
                                  bloc.add(
                                      UserNameChangeEvent(userName: value));
                                },
                                isObscure: false,
                              ),
                              if (state.isUserNameError &&
                                  state.nameError.isNotEmpty)
                                Text(
                                  state.nameError,
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextField(
                                label: "Password",
                                prefixIcon: 'assets/password_icon.png',
                                onValueChange: (value) {
                                  bloc.add(
                                      UserPasswordChangeEvent(password: value));
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
                              const SizedBox(height: 10),
                              Container(
                                width: width,
                                alignment: AlignmentDirectional.centerEnd,
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color(0xffA4A4A4),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(height: 10),
                              CustomButton(
                                width: width,
                                onPress: () {
                                  bloc.add(LoginUserRequest(
                                      user: User(
                                          userName: state.username,
                                          password: state.password,
                                      )));
                                },
                                btntext: "Sign in",
                                isEnable: !state.isUserNameError &&
                                    !state.isPasswordError,
                                isLoading: state.loginApi is Loading,
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
                              "Don't Have An Account?",
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
                              "Create Account",
                              style: TextStyle(
                                color: Color(0xffEFEFEF),
                                fontSize: 25,
                              ),
                            ),
                            onTap: () {
                              screenRouter.goNamed("sign_up");
                            },
                          ),
                        ),
                        SizedBox(
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
            );
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
