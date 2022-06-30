// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      lock: json['lock'] as bool?,
      status: json['status'] as bool?,
      isPhoneVerified: json['isPhoneVerified'] as bool?,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'lock': instance.lock,
      'status': instance.status,
      'isPhoneVerified': instance.isPhoneVerified,
    };
