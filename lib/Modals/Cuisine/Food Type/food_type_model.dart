// To parse this JSON data, do
//
//     final foodTypeModel = foodTypeModelFromJson(jsonString);

import 'dart:convert';

List<FoodTypeModel> foodTypeModelFromJson(String str) => List<FoodTypeModel>.from(json.decode(str).map((x) => FoodTypeModel.fromJson(x)));

String foodTypeModelToJson(List<FoodTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodTypeModel {
    FoodTypeModel({
        this.foodTypeCode,
        this.foodTypeName,
        this.imagePath,
    });

    dynamic foodTypeCode;
    String? foodTypeName;
    String? imagePath;

    factory FoodTypeModel.fromJson(Map<String, dynamic> json) => FoodTypeModel(
        foodTypeCode: json["foodTypeCode"],
        foodTypeName: json["foodTypeName"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
    );

    Map<String, dynamic> toJson() => {
        "foodTypeCode": foodTypeCode,
        "foodTypeName": foodTypeName,
        "imagePath": imagePath == null ? null : imagePath,
    };
}
