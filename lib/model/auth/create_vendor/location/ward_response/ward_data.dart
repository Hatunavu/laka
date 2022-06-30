import 'package:json_annotation/json_annotation.dart';

part 'ward_data.g.dart';

@JsonSerializable()
class WardData {
  String? code;
  String? name;
  String? unit;
  @JsonKey(name: 'district_code')
  String? districtCode;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'province_code')
  String? provinceCode;
  @JsonKey(name: 'province_name')
  String? provinceName;
  @JsonKey(name: 'full_name')
  String? fullName;

  WardData({
    this.code,
    this.name,
    this.unit,
    this.districtCode,
    this.districtName,
    this.provinceCode,
    this.provinceName,
    this.fullName,
  });

  factory WardData.fromJson(Map<String, dynamic> json) =>
      _$WardDataFromJson(json);

  Map<String, dynamic> toJson() => _$WardDataToJson(this);
}
