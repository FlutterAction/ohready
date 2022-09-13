class LoginModel {
  String? username;
  String? password;

  LoginModel({this.username, this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        username: json['userName'],
        password: json['pass'],
      );

  Map<String, dynamic> toJson() => {
        'userName': username,
        'pass': password,
      };
}
