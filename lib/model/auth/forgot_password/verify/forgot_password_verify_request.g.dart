// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordVerifyRequest _$ForgotPasswordVerifyRequestFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordVerifyRequest(
      phone: json['phone'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$ForgotPasswordVerifyRequestToJson(
        ForgotPasswordVerifyRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'code': instance.code,
    };
