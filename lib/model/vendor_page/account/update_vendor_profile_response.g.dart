// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_vendor_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateVendorProfileResponse _$UpdateVendorProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateVendorProfileResponse(
      status: json['status'] as int,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : VendorModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateVendorProfileResponseToJson(
        UpdateVendorProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
