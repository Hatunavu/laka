// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_service_item_gallery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateServiceItemGalleryResponse _$UpdateServiceItemGalleryResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateServiceItemGalleryResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdateServiceItemGalleryResponseToJson(
        UpdateServiceItemGalleryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };
