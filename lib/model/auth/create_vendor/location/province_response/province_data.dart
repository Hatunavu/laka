import 'package:json_annotation/json_annotation.dart';

part 'province_data.g.dart';

@JsonSerializable()
class ProvinceData {
  String? code;
  String? name;
  String? unit;

  ProvinceData({this.code, this.name, this.unit});

  factory ProvinceData.fromJson(Map<String, dynamic> json) =>
      _$ProvinceDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceDataToJson(this);
}
