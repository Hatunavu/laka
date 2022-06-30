// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAccountInformationResponse _$UpdateAccountInformationResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateAccountInformationResponse(
      account: json['data'] == null
          ? null
          : AccountModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateAccountInformationResponseToJson(
        UpdateAccountInformationResponse instance) =>
    <String, dynamic>{
      'data': instance.account,
      'status': instance.status,
      'message': instance.message,
    };
