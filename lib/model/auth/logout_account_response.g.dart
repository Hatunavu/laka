// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutAccountResponse _$LogoutAccountResponseFromJson(
        Map<String, dynamic> json) =>
    LogoutAccountResponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$LogoutAccountResponseToJson(
        LogoutAccountResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
