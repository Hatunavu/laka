// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_checkphone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninCheckPhoneResponse _$SigninCheckPhoneResponseFromJson(
        Map<String, dynamic> json) =>
    SigninCheckPhoneResponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SigninCheckPhoneResponseToJson(
        SigninCheckPhoneResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
