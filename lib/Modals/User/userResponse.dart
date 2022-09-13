class UserResponse {
  UserResponse(
      {this.result,
      this.userCode,
      this.userName,
      this.email,
      this.accountType,
      this.googleId,
      this.facebookId,
      this.imagePath});

  String? result, userName, email, accountType, googleId, facebookId, imagePath;
  int? userCode;
  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        result: json["result"],
        userCode: json["userCode"],
        userName: json["userName"],
        imagePath: json['imagePath'] ?? null,
        email: json["email"],
        accountType: json["accountType"],
        googleId: json["googleID"],
        facebookId: json["facebookID"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "userCode": userCode,
        "userName": userName,
        "imagePath": imagePath,
        "email": email,
        "accountType": accountType,
        "googleID": googleId,
        "facebookID": facebookId,
      };
}
