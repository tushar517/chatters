class User{
  String userName;
  String fullName;
  bool status;
  String password;
  String gender;
  DateTime? lastSeen;
  String lastSeenTime;

  User(
      {required this.userName,
        this.fullName = "",
        this.status = false,
        this.password = "",
        this.gender = "Male",
        this.lastSeen,
        this.lastSeenTime = ""});
}