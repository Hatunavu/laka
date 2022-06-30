// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_customer_rewards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCustomerRewardsResponse _$GetCustomerRewardsResponseFromJson(
        Map<String, dynamic> json) =>
    GetCustomerRewardsResponse(
      data: json['data'] == null
          ? null
          : RewardData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetCustomerRewardsResponseToJson(
        GetCustomerRewardsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
