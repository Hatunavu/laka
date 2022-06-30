// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doc _$DocFromJson(Map<String, dynamic> json) => Doc(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      vendor: json['vendor'] as String?,
      reviewer: json['reviewer'] == null
          ? null
          : Reviewer.fromJson(json['reviewer'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble(),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$DocToJson(Doc instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'vendor': instance.vendor,
      'reviewer': instance.reviewer,
      'rating': instance.rating,
      'gallery': instance.gallery,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
