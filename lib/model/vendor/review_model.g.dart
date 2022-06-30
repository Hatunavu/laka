// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      createdAt: json['createdAt'] as String?,
      id: json['_id'] as String?,
      content: json['content'] as String?,
      reviewer: json['reviewer'] == null
          ? null
          : AccountModel.fromJson(json['reviewer'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble(),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'reviewer': instance.reviewer,
      'rating': instance.rating,
      'createdAt': instance.createdAt,
      'gallery': instance.gallery,
    };
