// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardData _$WardDataFromJson(Map<String, dynamic> json) => WardData(
      code: json['code'] as String?,
      name: json['name'] as String?,
      unit: json['unit'] as String?,
      districtCode: json['district_code'] as String?,
      districtName: json['district_name'] as String?,
      provinceCode: json['province_code'] as String?,
      provinceName: json['province_name'] as String?,
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$WardDataToJson(WardData instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'unit': instance.unit,
      'district_code': instance.districtCode,
      'district_name': instance.districtName,
      'province_code': instance.provinceCode,
      'province_name': instance.provinceName,
      'full_name': instance.fullName,
    };
