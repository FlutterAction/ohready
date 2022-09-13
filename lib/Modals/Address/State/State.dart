// ignore_for_file: non_constant_identifier_names

class StateModel {
  int? stateCode;
  String? stateName;

  StateModel({this.stateCode, this.stateName});

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        stateCode: json['StateCode'],
        stateName: json['StateName'],
      );

  Map<String, dynamic> toJson() => {
        'StateCode': stateCode,
        'StateName': stateName,
      };
}
