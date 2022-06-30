// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_calculate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreCalculateResponse _$PreCalculateResponseFromJson(
        Map<String, dynamic> json) =>
    PreCalculateResponse(
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$PreCalculateResponseToJson(
        PreCalculateResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
