// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_deceive_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddDeceiveTokenRequest _$AddDeceiveTokenRequestFromJson(
        Map<String, dynamic> json) =>
    AddDeceiveTokenRequest(
      deviceToken: json['deviceToken'] as String,
      deviceType: json['deviceType'] as String,
    );

Map<String, dynamic> _$AddDeceiveTokenRequestToJson(
        AddDeceiveTokenRequest instance) =>
    <String, dynamic>{
      'deviceToken': instance.deviceToken,
      'deviceType': instance.deviceType,
    };
