class UserRequest{
  String userName;
  String fullName;
  bool status;
  String password;
  String gender;
  DateTime? lastSeen;
  String lastSeenTime;

  UserRequest(
      {required this.userName,
        this.fullName = "",
        this.status = false,
        this.password = "",
        this.gender = "Male",
        this.lastSeen,
        this.lastSeenTime = ""});

  Map<String, dynamic> toJson() => {
    "userName": userName,
    "fullName": fullName,
    "status": status,
    "password": password,
    "gender": gender,
    "lastSeen": lastSeen ?? DateTime.now().toIso8601String()
  };

}