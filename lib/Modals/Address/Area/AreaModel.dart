class AreaModel {
  int? areaCode;
  String? areaName;

  AreaModel({this.areaCode, this.areaName});

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        areaCode: json['AreaCode'],
        areaName: json['AreaName'],
      );

  Map<String, dynamic> toJson() => {
        'AreaCode': areaCode,
        'AreaName': areaName,
      };
}
