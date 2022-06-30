// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_account_information_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateAccountInformationRequest _$UpdateAccountInformationRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateAccountInformationRequest(
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      biography: json['biography'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UpdateAccountInformationRequestToJson(
        UpdateAccountInformationRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'biography': instance.biography,
      'gender': instance.gender,
    };
