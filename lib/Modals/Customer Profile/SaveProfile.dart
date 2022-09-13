class SaveProfile {
  String? email;
  String? pass;
  String? mobileno;
  String? firstName;
  String? lastname;
  String? gender;
  String? dob;
  var img;

  SaveProfile(
      {this.dob,
      this.email,
      this.firstName,
      this.gender,
      this.img,
      this.lastname,
      this.mobileno,
      this.pass});

  factory SaveProfile.fromJson(Map<String, dynamic> json) => SaveProfile(
      email: json['email'],
      pass: json['pass'],
      firstName: json['firstName'],
      lastname: json['lastname'],
      mobileno: json['mobileno'],
      gender: json['gender'],
      dob: json['dob'],
      img: json['img']);

  Map<String, dynamic> toJson() => {
        'email': email,
        'pass': pass,
        'firstName': firstName,
        'lastname': lastname,
        'mobileno': mobileno,
        'gender': gender,
        'dob': dob,
        'img': img,
      };
}
