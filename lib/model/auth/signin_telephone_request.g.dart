// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_telephone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninTelephoneRequest _$SigninTelephoneRequestFromJson(
        Map<String, dynamic> json) =>
    SigninTelephoneRequest(
      phone: json['phone'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$SigninTelephoneRequestToJson(
        SigninTelephoneRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'code': instance.code,
    };
