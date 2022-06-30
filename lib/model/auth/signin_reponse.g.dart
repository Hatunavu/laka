// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_reponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) =>
    SigninResponse(
      userSession: json['data'] == null
          ? null
          : UserSession.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'data': instance.userSession,
      'status': instance.status,
      'message': instance.message,
    };
