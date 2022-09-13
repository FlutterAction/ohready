class Address {
  Address({
    this.addressCode,
    this.customerCode,
    this.placeName,
    this.mobileNo,
    this.stateCode,
    this.cityCode,
    this.areaCode,
    this.locationLat,
    this.locationLong,
    this.addressText,
    this.zipcode,
  });

  int? addressCode;
  int? customerCode;
  String? placeName;
  String? mobileNo;
  int? stateCode;
  int? cityCode;
  int? areaCode;
  double? locationLat;
  double? locationLong;
  String? addressText;
  String? zipcode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressCode: json["addressCode"],
        customerCode: json["customerCode"],
        placeName: json["fullName"],
        mobileNo: json["mobileNo"],
        stateCode: json["stateCode"],
        cityCode: json["cityCode"],
        areaCode: json["areaCode"],
        locationLat: json["locationLat"],
        locationLong: json["locationLong"],
        addressText: json["addressText"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "addressCode": addressCode,
        "customerCode": customerCode,
        "fullName": placeName,
        "mobileNo": mobileNo,
        "stateCode": stateCode,
        "cityCode": cityCode,
        "areaCode": areaCode,
        "locationLat": locationLat,
        "locationLong": locationLong,
        "addressText": addressText,
        "zipcode": zipcode,
      };
}
