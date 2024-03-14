class ApiResponse{
  String description;
  bool status;
  ApiResponse({
    required this.status,
    required this.description
});

  @override
  String toString() {
    return 'ApiResponse{description: $description, status: $status}';
  }

  factory ApiResponse.fromJson(Map<String,dynamic> json){
    return ApiResponse(status: json["status"], description: json["description"]);
  }
}