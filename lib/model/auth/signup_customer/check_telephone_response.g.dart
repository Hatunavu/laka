// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_telephone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTelephoneResponse _$CheckTelephoneResponseFromJson(
        Map<String, dynamic> json) =>
    CheckTelephoneResponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$CheckTelephoneResponseToJson(
        CheckTelephoneResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
