import 'dart:convert';

import 'package:chat_app/data/models/ApiResponse.dart';
import 'package:chat_app/data/models/user.dart';
import '../commonutils/http_service.dart';

abstract interface class AuthRemoteDataSource{
  Future<ApiResponse> signUp({required User user});

  Future<ApiResponse> logIn({required User user});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  @override
  Future<ApiResponse> logIn({required User user}) async {
    try {
      var response = await dio.post(
          "user/loginUser",
          data: json.encode(user.toJson())
      );
      print(json.encode(user.toJson()));
      if (response.statusCode == 200) {
        print(response.data);
        return ApiResponse.fromJson(response.data);
      }
    } catch (ex) {
      print(ex.toString());
      return ApiResponse(status: false, description: ex.toString());
    }
    return ApiResponse(status: false, description: "Something went wrong");
  }

  @override
  Future<ApiResponse> signUp({required User user})async {
    try {
      var response = await dio.post(
          "user/createUser",
          data: json.encode(user.toJson())
      );
      print(json.encode(user.toJson()));
      if (response.statusCode == 200) {
        print(response.data);
        return ApiResponse.fromJson(response.data);
      }
    } catch (ex) {
      print(ex.toString());
      return ApiResponse(status: false, description: ex.toString());
    }
    return ApiResponse(status: false, description: "Something went wrong");
  }

}