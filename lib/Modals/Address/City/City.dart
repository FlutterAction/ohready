class City {
  int? cityCode;
  String? cityName;

  City({this.cityCode, this.cityName});

  factory City.fromJson(Map<String, dynamic> json) => City(
        cityCode: json['CityCode'],
        cityName: json['CityName'],
      );

  Map<String, dynamic> toJson() => {
        'CityCode': cityCode,
        'CityName': cityName,
      };
}
