import 'package:secure_hops/Modals/User/userResponse.dart';

class LoginResponse {
  LoginResponse({this.password, this.user});

  UserResponse? user;
  String? password;
  factory LoginResponse.fromJson(Map<String, dynamic> map, String? password) =>
      LoginResponse(user: UserResponse.fromJson(map), password: password);

  Map<String, dynamic> toJson() => {"user": user, "password": password};
}
