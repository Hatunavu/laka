// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_service_item_thumbnail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateServiceItemThumbnailResponse _$UpdateServiceItemThumbnailResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateServiceItemThumbnailResponse(
      data: json['data'] == null
          ? null
          : ImageModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateServiceItemThumbnailResponseToJson(
        UpdateServiceItemThumbnailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
