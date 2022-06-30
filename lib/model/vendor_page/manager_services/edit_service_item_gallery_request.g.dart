// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_service_item_gallery_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateServiceItemGalleryRequest _$UpdateServiceItemGalleryRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateServiceItemGalleryRequest(
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UpdateServiceItemGalleryRequestToJson(
        UpdateServiceItemGalleryRequest instance) =>
    <String, dynamic>{
      'images': instance.images,
    };
