// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_poster_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsPosterResponse _$VendorsPosterResponseFromJson(
        Map<String, dynamic> json) =>
    VendorsPosterResponse(
      data: VendorsPosterResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$VendorsPosterResponseToJson(
        VendorsPosterResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

VendorsPosterResponseData _$VendorsPosterResponseDataFromJson(
        Map<String, dynamic> json) =>
    VendorsPosterResponseData(
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      recommendVendors: (json['recommendVendors'] as List<dynamic>?)
          ?.map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VendorsPosterResponseDataToJson(
        VendorsPosterResponseData instance) =>
    <String, dynamic>{
      'banners': instance.banners,
      'recommendVendors': instance.recommendVendors,
    };
