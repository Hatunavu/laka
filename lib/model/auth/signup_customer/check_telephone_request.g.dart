// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_telephone_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckTelephoneRequest _$CheckTelephoneRequestFromJson(
        Map<String, dynamic> json) =>
    CheckTelephoneRequest(
      phone: json['phone'] as String,
      referralBy: json['referralBy'] as String,
      fullName: json['fullName'] as String,
    );

Map<String, dynamic> _$CheckTelephoneRequestToJson(
        CheckTelephoneRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'referralBy': instance.referralBy,
      'fullName': instance.fullName,
    };
