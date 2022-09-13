class DeleteAddress {
  String? userName;
  String? userPass;
  String? addressCode;

  DeleteAddress({this.userName, this.userPass, this.addressCode});

  factory DeleteAddress.fromJson(Map<String, dynamic> json) => DeleteAddress(
      userName: json['userName'],
      userPass: json['userPass'],
      addressCode: json['addressCode']);

  Map<String, dynamic> toJson() =>
      {'userName': userName, 'userPass': userPass, 'addressCode': addressCode};
}
