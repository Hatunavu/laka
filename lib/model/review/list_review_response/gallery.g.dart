// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) => GalleryModel(
      id: json['_id'] as String?,
      path: json['path'] as String?,
      type: json['type'] as String?,
      pathUrl: json['pathUrl'] as String?,
    );

Map<String, dynamic> _$GalleryModelToJson(GalleryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'path': instance.path,
      'type': instance.type,
      'pathUrl': instance.pathUrl,
    };
