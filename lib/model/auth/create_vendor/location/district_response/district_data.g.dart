// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictData _$DistrictDataFromJson(Map<String, dynamic> json) => DistrictData(
      code: json['code'] as String?,
      name: json['name'] as String?,
      unit: json['unit'] as String?,
      provinceCode: json['province_code'] as String?,
      provinceName: json['province_name'] as String?,
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$DistrictDataToJson(DistrictData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'unit': instance.unit,
      'province_code': instance.provinceCode,
      'province_name': instance.provinceName,
      'full_name': instance.fullName,
    };
