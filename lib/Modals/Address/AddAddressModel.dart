class AddAdressModel {
  String? userName,
      userPassword,
      placeName,
      phoneNo,
      country,
      state,
      city,
      area,
      zip,
      newAddress,
      lat,
      long,
      update,
      addressCode;

  AddAdressModel(
      {this.userName,
      this.userPassword,
      this.newAddress,
      this.addressCode,
      this.area,
      this.city,
      this.country,
      this.placeName,
      this.lat,
      this.long,
      this.phoneNo,
      this.state,
      this.update,
      this.zip});

  factory AddAdressModel.fromJson(Map<String, dynamic> json) => AddAdressModel(
        userName: json['userName'],
        userPassword: json['userPass'],
        placeName: json['fullName'],
        phoneNo: json['mobileNo'],
        country: json['countryCode'],
        state: json['stateCode'],
        city: json['cityCode'],
        area: json['areaCode'],
        zip: json['zipCode'],
        newAddress: json['addressText'],
        lat: json['locationLat'],
        long: json['locationLong'],
        update: json['doUpdate'],
        addressCode: json['addressCode'],
      );

  Map<String, dynamic> toJson() => {
        'userName': userName,
        'userPass': userPassword,
        'fullName': placeName,
        'mobileNo': phoneNo,
        'countryCode': country,
        'stateCode': state,
        'cityCode': city,
        'areaCode': area,
        'zipCode': zip,
        'addressText': newAddress,
        'locationLat': lat,
        'locationLong': long,
        'doUpdate': update,
        'addressCode': addressCode
      };
}
