// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorDetailResponse _$VendorDetailResponseFromJson(
        Map<String, dynamic> json) =>
    VendorDetailResponse(
      vendorItem: json['data'] == null
          ? null
          : VendorModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorDetailResponseToJson(
        VendorDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.vendorItem,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
