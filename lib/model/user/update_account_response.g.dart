// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAccountResponse _$UpdateAccountResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateAccountResponse(
      data: json['data'] == null
          ? null
          : AvatarAccount.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateAccountResponseToJson(
        UpdateAccountResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
