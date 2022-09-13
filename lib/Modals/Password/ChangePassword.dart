class ChangePassword {
  String? oldpass;
  String? newpass;
  String? usercode;

  ChangePassword({this.newpass, this.oldpass, this.usercode});

  factory ChangePassword.fromJson(Map<String, dynamic> json) => ChangePassword(
        oldpass: json['oldPass'],
        newpass: json['newPass'],
        usercode: json['userCode'],
      );

  Map<String, dynamic> toJson() => {
        'oldPass': oldpass,
        'newPass': newpass,
        'userCode': usercode,
      };
}
