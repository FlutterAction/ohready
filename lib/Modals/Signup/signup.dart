class Signup {
  Signup({
    this.email,
    this.userName,
    this.pass,
    this.firstName,
    this.lastName,
    this.accountType,
    this.mobile,
    this.from,
    this.facebookId,
    this.googleId,
  });

  String? email,
      userName,
      pass,
      firstName,
      lastName,
      accountType,
      mobile,
      from,
      facebookId,
      googleId;

  factory Signup.fromJson(Map<String, dynamic> json) => Signup(
        email: json["email"],
        userName: json["userName"],
        pass: json["pass"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        accountType: json["accountType"],
        mobile: json["mobile"],
        from: json["from"],
        facebookId: json["facebookId"],
        googleId: json["googleId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userName": userName,
        "pass": pass,
        "firstName": firstName,
        "lastName": lastName,
        "accountType": accountType,
        "mobile": mobile,
        "from": from,
        "facebookId": facebookId,
        "googleId": googleId,
      };
}
