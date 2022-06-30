// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_read_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReadNotificationResponse _$UpdateReadNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateReadNotificationResponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateReadNotificationResponseToJson(
        UpdateReadNotificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
