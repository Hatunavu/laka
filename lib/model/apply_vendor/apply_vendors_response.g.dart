// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_vendors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyVendorResponse _$ApplyVendorResponseFromJson(Map<String, dynamic> json) =>
    ApplyVendorResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ApplyVendorResponseToJson(
        ApplyVendorResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
