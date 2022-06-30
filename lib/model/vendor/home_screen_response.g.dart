// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeScreenResponse _$HomeScreenResponseFromJson(Map<String, dynamic> json) =>
    HomeScreenResponse(
      data: json['data'] == null
          ? null
          : HotAndSuggestVendors.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$HomeScreenResponseToJson(HomeScreenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

HotAndSuggestVendors _$HotAndSuggestVendorsFromJson(
        Map<String, dynamic> json) =>
    HotAndSuggestVendors(
      hotVendors: (json['hotVendors'] as List<dynamic>)
          .map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      suggestedVendors: (json['suggestedVendors'] as List<dynamic>)
          .map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      appVersion: json['appVersion'] as String? ?? '0.1.3',
    );

Map<String, dynamic> _$HotAndSuggestVendorsToJson(
        HotAndSuggestVendors instance) =>
    <String, dynamic>{
      'hotVendors': instance.hotVendors,
      'suggestedVendors': instance.suggestedVendors,
      'banners': instance.banners,
      'appVersion': instance.appVersion,
    };
