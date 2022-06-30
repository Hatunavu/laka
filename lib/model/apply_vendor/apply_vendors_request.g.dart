// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_vendors_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyVendorsRequest _$ApplyVendorsRequestFromJson(Map<String, dynamic> json) =>
    ApplyVendorsRequest(
      brandName: json['brandName'] as String,
      fullName: json['fullName'] as String,
      fullAddress: json['fullAddress'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$ApplyVendorsRequestToJson(
        ApplyVendorsRequest instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'fullName': instance.fullName,
      'fullAddress': instance.fullAddress,
      'phone': instance.phone,
      'email': instance.email,
    };
