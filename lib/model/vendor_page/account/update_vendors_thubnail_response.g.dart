// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_vendors_thubnail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateVendorsThumbnailResponse _$UpdateVendorsThumbnailResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateVendorsThumbnailResponse(
      data: json['data'] == null
          ? null
          : VendorThumbnail.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateVendorsThumbnailResponseToJson(
        UpdateVendorsThumbnailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
