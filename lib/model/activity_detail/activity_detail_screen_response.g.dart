// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_detail_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityDetailScreenResponse _$ActivityDetailScreenResponseFromJson(
        Map<String, dynamic> json) =>
    ActivityDetailScreenResponse(
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ActivityDetailScreenResponseToJson(
        ActivityDetailScreenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
