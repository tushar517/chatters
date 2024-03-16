import 'package:chat_app/commonutils/init_dependencies.dart';
import 'package:chat_app/commonutils/router/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/chat/chat_bloc.dart';
import 'presentation/bloc/login/login_bloc.dart';
import 'presentation/bloc/signup/sign_up_bloc.dart';
import 'presentation/bloc/userList/user_list_bloc.dart';

void main() async{
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context)=>getItInstance<LoginBloc>()),
        BlocProvider<SignUpBloc>(create: (BuildContext context)=>getItInstance<SignUpBloc>()),
        BlocProvider<UserListBloc>(create: (BuildContext context)=>getItInstance<UserListBloc>()),
        BlocProvider<ChatBloc>(create: (BuildContext context)=>getItInstance<ChatBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Chatters',
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
