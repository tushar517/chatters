import 'package:chat_app/domain/entities/ApiResponse.dart';

class ApiResponseModel extends ApiResponse{
  ApiResponseModel({
    required super.status,
    required super.description
});

  @override
  String toString() {
    return 'ApiResponse{description: $description, status: $status}';
  }

  factory ApiResponseModel.fromJson(Map<String,dynamic> json){
    return ApiResponseModel(status: json["status"], description: json["description"]);
  }
}