// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceDetailResponse _$ServiceDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ServiceDetailResponse(
      data: json['data'] == null
          ? null
          : ServicesModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ServiceDetailResponseToJson(
        ServiceDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
