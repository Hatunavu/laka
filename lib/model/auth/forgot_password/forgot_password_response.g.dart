// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordReponse _$ForgotPasswordReponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordReponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ForgotPasswordReponseToJson(
        ForgotPasswordReponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
