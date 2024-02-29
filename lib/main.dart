import 'dart:convert';

import 'package:chat_app/bloc/chat/chat_bloc.dart';
import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/bloc/signup/sign_up_bloc.dart';
import 'package:chat_app/bloc/userList/user_list_bloc.dart';
import 'package:chat_app/router/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'StompClient/stomp_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context)=>LoginBloc()),
        BlocProvider<SignUpBloc>(create: (BuildContext context)=>SignUpBloc()),
        BlocProvider<UserListBloc>(create: (BuildContext context)=>UserListBloc()),
        BlocProvider<ChatBloc>(create: (BuildContext context)=>ChatBloc()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Poppins'
        ),
        routerConfig: screenRouter,
      ),
    );
  }
}
