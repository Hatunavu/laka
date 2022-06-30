// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardScreenResponse _$RewardScreenResponseFromJson(
        Map<String, dynamic> json) =>
    RewardScreenResponse(
      data: json['data'] == null
          ? null
          : RewardScreenData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$RewardScreenResponseToJson(
        RewardScreenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

RewardScreenData _$RewardScreenDataFromJson(Map<String, dynamic> json) =>
    RewardScreenData(
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      systemVouchers: (json['systemVouchers'] as List<dynamic>?)
          ?.map((e) => VoucherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendorVouchers: (json['vendorVouchers'] as List<dynamic>?)
          ?.map((e) => VoucherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RewardScreenDataToJson(RewardScreenData instance) =>
    <String, dynamic>{
      'banners': instance.banners,
      'systemVouchers': instance.systemVouchers,
      'vendorVouchers': instance.vendorVouchers,
    };
