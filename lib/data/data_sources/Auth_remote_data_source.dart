import 'dart:convert';

import 'package:chat_app/commonutils/api_request/user_request.dart';
import 'package:chat_app/data/models/api_response_model.dart';
import '../../commonutils/http_service.dart';

abstract interface class AuthRemoteDataSource{
  Future<ApiResponseModel> signUp({required UserRequest user});

  Future<ApiResponseModel> logIn({required UserRequest user});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  @override
  Future<ApiResponseModel> logIn({required UserRequest user}) async {
    try {
      var response = await dio.post(
          "user/loginUser",
          data: json.encode(user.toJson())
      );
      print(json.encode(user.toJson()));
      if (response.statusCode == 200) {
        print(response.data);
        return ApiResponseModel.fromJson(response.data);
      }
    } catch (ex) {
      print(ex.toString());
      return ApiResponseModel(status: false, description: ex.toString());
    }
    return ApiResponseModel(status: false, description: "Something went wrong");
  }

  @override
  Future<ApiResponseModel> signUp({required UserRequest user})async {
    try {
      var response = await dio.post(
          "user/createUser",
          data: json.encode(user.toJson())
      );
      print(json.encode(user.toJson()));
      if (response.statusCode == 200) {
        print(response.data);
        return ApiResponseModel.fromJson(response.data);
      }
    } catch (ex) {
      print(ex.toString());
      return ApiResponseModel(status: false, description: ex.toString());
    }
    return ApiResponseModel(status: false, description: "Something went wrong");
  }

}