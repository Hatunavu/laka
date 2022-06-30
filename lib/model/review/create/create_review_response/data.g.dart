// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      content: json['content'] as String?,
      order: json['order'] as String?,
      vendor: json['vendor'] as String?,
      reviewer: json['reviewer'] as String?,
      rating: json['rating'] as int?,
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => Gallery.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'content': instance.content,
      'order': instance.order,
      'vendor': instance.vendor,
      'reviewer': instance.reviewer,
      'rating': instance.rating,
      'gallery': instance.gallery,
      '_id': instance.id,
    };

Gallery _$GalleryFromJson(Map<String, dynamic> json) => Gallery(
      path: json['path'] as String?,
      type: json['type'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$GalleryToJson(Gallery instance) => <String, dynamic>{
      'path': instance.path,
      'type': instance.type,
      '_id': instance.id,
    };
