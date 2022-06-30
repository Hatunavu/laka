// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fotgot_password_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordVerifyResponse _$ForgotPasswordVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordVerifyResponse(
      data: json['data'] == null
          ? null
          : ForgotPasswordVerifyData.fromJson(
              json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ForgotPasswordVerifyResponseToJson(
        ForgotPasswordVerifyResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

ForgotPasswordVerifyData _$ForgotPasswordVerifyDataFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordVerifyData(
      token: json['token'] as String,
    );

Map<String, dynamic> _$ForgotPasswordVerifyDataToJson(
        ForgotPasswordVerifyData instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
