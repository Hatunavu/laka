// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmResponse _$FcmResponseFromJson(Map<String, dynamic> json) => FcmResponse(
      data: FcmResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FcmResponseToJson(FcmResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

FcmResponseData _$FcmResponseDataFromJson(Map<String, dynamic> json) =>
    FcmResponseData(
      postId: json['postId'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$FcmResponseDataToJson(FcmResponseData instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'type': instance.type,
    };
