import 'dart:io';

import 'package:dio/dio.dart';

String baseUrl = "https://chat-services.onrender.com/";
// String baseUrl ="http://localhost:8088/";

final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    },
    connectTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
  ),
);

void main() {
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      request: true,
      responseBody: true,
    ),
  );
}
