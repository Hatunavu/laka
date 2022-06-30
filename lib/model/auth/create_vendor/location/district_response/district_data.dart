import 'package:json_annotation/json_annotation.dart';

part 'district_data.g.dart';

@JsonSerializable()
class DistrictData {
  String? code;
  String? name;
  String? unit;
  @JsonKey(name: 'province_code')
  String? provinceCode;
  @JsonKey(name: 'province_name')
  String? provinceName;
  @JsonKey(name: 'full_name')
  String? fullName;

  DistrictData({
    this.code,
    this.name,
    this.unit,
    this.provinceCode,
    this.provinceName,
    this.fullName,
  });

  factory DistrictData.fromJson(Map<String, dynamic> json) =>
      _$DistrictDataFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictDataToJson(this);
}
