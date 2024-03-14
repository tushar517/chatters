import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

final StompClient stompClient = StompClient(
  config: StompConfig(
      url: 'https://chat-services.onrender.com/ws',
      onConnect: onConnect,
      onStompError: onFail,
      onWebSocketError: onSocketError,
      stompConnectHeaders: {
        "Sec-WebSocket-Version": "13",
        "Sec-WebSocket-Key": "uIcWxjqfLo45jA1p2WWKrw==",
        "Connection": "Upgrade",
        "Upgrade": "websocket"
      },
      onDebugMessage: (value){
        print(value);
      },
      useSockJS: true),
);

void onConnect(StompFrame stompFrame) {
  print(stompFrame.body);
}

void onSocketError(dynamic) {
  print(dynamic);
}

void onFail(StompFrame frame) {
  print(frame.body);
}