import 'dart:convert';

List<Cuisine> cuisineFromJson(String str) =>
    List<Cuisine>.from(json.decode(str).map((x) => Cuisine.fromJson(x)));

String cuisineToJson(List<Cuisine> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cuisine {
  Cuisine({
    this.cuisineCode,
    this.cuisineName,
    this.imagePath,
  });

  int? cuisineCode;
  String? cuisineName;
  String? imagePath;

  factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
        cuisineCode: json["cuisineCode"],
        cuisineName: json["cuisineName"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "cuisineCode": cuisineCode,
        "cuisineName": cuisineName,
        "imagePath": imagePath == null ? null : imagePath,
      };
}
