// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vendor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateVendorResponse _$CreateVendorResponseFromJson(
        Map<String, dynamic> json) =>
    CreateVendorResponse(
      data: json['data'] == null
          ? null
          : VendorInfoModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$CreateVendorResponseToJson(
        CreateVendorResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
