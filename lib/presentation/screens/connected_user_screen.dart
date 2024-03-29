import 'dart:convert';
import 'dart:math';
import 'package:chat_app/commonutils/Result.dart';
import 'package:chat_app/data/models/user_model.dart';
import 'package:chat_app/presentation/bloc/userList/user_list_bloc.dart';
import 'package:chat_app/presentation/common_widgets/custom_values.dart';
import 'package:chat_app/commonutils/router/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../commonutils/StompClient/stomp_client.dart';

class ConnectedUsers extends StatelessWidget {
  final String nickName;

  const ConnectedUsers({super.key, required this.nickName});

  @override
  Widget build(BuildContext parentContext) {
    double height = MediaQuery.of(parentContext).size.height;
    double width = MediaQuery.of(parentContext).size.width;
    var bloc = parentContext.read<UserListBloc>()
      ..add(InitUserScreen(nickName));
    subscribeStomp(bloc);
    return BlocConsumer<UserListBloc, UserListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: (state.userApi is Loading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      width: width,
                      height: height,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: const Text(
                                    'Home',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color(
                                        0xff555358,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      stompClient.send(
                                          destination:
                                              "/app/user/disconnectUser",
                                          body: jsonEncode({
                                            "userName": nickName,
                                          }));
                                      screenRouter.goNamed('login');
                                    },
                                    icon: const Icon(Icons.exit_to_app,
                                        size: 24,
                                        color: Color(
                                          0xff555358,
                                        )))
                              ]),
                          if (state.connectedUserList.isNotEmpty)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: textGradient,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(28))),
                                  padding: const EdgeInsets.all(10),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Currently Active',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.green,
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 145,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext buildContext, int index) {
                                      String img = '';
                                      if (state.connectedUserList[index]
                                              .gender ==
                                          'Male') {
                                        int index = Random()
                                            .nextInt(state.maleImg.length - 1);
                                        img = state.maleImg[index];
                                      } else {
                                        int index = Random().nextInt(
                                            state.femaleImg.length - 1);
                                        img = state.femaleImg[index];
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            screenRouter.goNamed("chat_screen",
                                                pathParameters: {
                                                  "nickName": nickName,
                                                  "profileImg": img
                                                },
                                                extra: state
                                                    .connectedUserList[index]);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            key: ValueKey(state
                                                .connectedUserList[index]
                                                .userName),
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                37)),
                                                    color: Colors.red,
                                                    image: DecorationImage(
                                                        image: AssetImage(img),
                                                        fit: BoxFit.fill)),
                                                height: 107,
                                                width: 84,
                                              ),
                                              Text(
                                                state.connectedUserList[index]
                                                    .fullName,
                                                style: const TextStyle(
                                                    color: Color(0xffC8C8C8),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.connectedUserList.length,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          if (state.disconnectedUserList.isNotEmpty)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: textGradient,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(28))),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Recently Active',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset('assets/time.png'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext buildContext, int index) {
                                        String img = '';
                                        if (state.disconnectedUserList[index]
                                                .gender ==
                                            'Male') {
                                          int index = Random()
                                              .nextInt(state.maleImg.length - 1);
                                          img = state.maleImg[index];
                                        } else {
                                          int index = Random().nextInt(
                                              state.femaleImg.length - 1);
                                          img = state.femaleImg[index];
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            screenRouter.goNamed("chat_screen",
                                                pathParameters: {
                                                  "nickName": nickName,
                                                  "profileImg": img
                                                },
                                                extra: state
                                                    .disconnectedUserList[index]);
                                          },
                                          child: IntrinsicWidth(
                                            child: Container(
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffC8C8C8)),
                                                  color: const Color(0xff1F1F1F)),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                key: ValueKey(state
                                                    .disconnectedUserList[index]
                                                    .userName),
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    100)),
                                                        color: Colors.red,
                                                        image: DecorationImage(
                                                            image:
                                                                AssetImage(img),
                                                            fit: BoxFit.fill)),
                                                    height: 107,
                                                    width: 84,
                                                  ),
                                                  Text(
                                                    state
                                                        .disconnectedUserList[
                                                            index]
                                                        .fullName,
                                                    style: const TextStyle(
                                                        color: Color(0xffC8C8C8),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    state
                                                        .disconnectedUserList[
                                                            index]
                                                        .lastSeenTime,
                                                    style: const TextStyle(
                                                        color: Color(0xff7C01F6),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          state.disconnectedUserList.length,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
          backgroundColor: const Color(0xff121111),
        );
      },
    );
  }

  void subscribeStomp(UserListBloc bloc) {
    stompClient.subscribe(
      destination: "/user/topic",
      callback: (StompFrame frame) {
        try {
          print("stomp user ${frame.body!}");
          UserModel user = UserModel.fromJson(json.decode(frame.body!));
          if (user.status) {
            bloc.add(StompAddUser(user: user));
          } else {
            bloc.add(StompRemoveUser(user: user));
          }
        } catch (ex) {
          print(ex);
        }
      },
    );
  }
}
