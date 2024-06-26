import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/presentation/screens/chat_screen.dart';
import 'package:chat_app/presentation/screens/connected_user_screen.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:chat_app/presentation/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GoRouter screenRouter = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    name: 'login',
    builder: (BuildContext buildContext, GoRouterState state) {
      return const UserLogin();
    },
    routes: [
      GoRoute(
          path: 'signUp',
          name: "sign_up",
          builder:(BuildContext buildContext,GoRouterState state){
            return const SignUpScreen();
          }
      ),
    ]
  ),
  GoRoute(
      path: '/connectedUser/:nickName',
      name: "connected_user",
      builder: (BuildContext buildContext, GoRouterState state) {
        return ConnectedUsers(
          nickName: state.pathParameters["nickName"] ?? "",
        );
      },
      routes: [
        GoRoute(
            path: 'ChatScreen/:profileImg',
            name: 'chat_screen',
            builder: (BuildContext buildContext, GoRouterState state) {
              final user = state.extra as UserModel;
              return ChatScreen(
                senderNickname: state.pathParameters["nickName"] ?? "",
                receiverUser: user,
                profileImg: state.pathParameters["profileImg"]??"",
              );
            }
        ),
      ]
  ),

]);