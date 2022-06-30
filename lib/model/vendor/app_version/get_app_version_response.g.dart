// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_app_version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppVersionResponse _$GetAppVersionResponseFromJson(
        Map<String, dynamic> json) =>
    GetAppVersionResponse(
      data: json['data'] == null
          ? null
          : AppVersionData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetAppVersionResponseToJson(
        GetAppVersionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

AppVersionData _$AppVersionDataFromJson(Map<String, dynamic> json) =>
    AppVersionData(
      iosVersion: json['iosVersion'] as String,
      androidVersion: json['androidVersion'] as String,
    );

Map<String, dynamic> _$AppVersionDataToJson(AppVersionData instance) =>
    <String, dynamic>{
      'iosVersion': instance.iosVersion,
      'androidVersion': instance.androidVersion,
    };
