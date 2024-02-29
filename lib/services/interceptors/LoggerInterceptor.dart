import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor{

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.data);
    super.onResponse(response, handler);
  }
}