// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordUpdateReponse _$ForgotPasswordUpdateReponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordUpdateReponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ForgotPasswordUpdateReponseToJson(
        ForgotPasswordUpdateReponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
