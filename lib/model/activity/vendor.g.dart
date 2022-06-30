// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      owner: json['owner'] as String?,
      category: stringToCategoryType(json['category'] as String),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gallery: (json['gallery'] as List<dynamic>?)
          ?.map((e) => Gallery.fromJson(e as Map<String, dynamic>))
          .toList(),
      brandName: json['brandName'] as String?,
      thumbnail: json['thumbnail'] == null
          ? null
          : Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String?,
      categoryImage: json['categoryImage'] as String?,
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'address': instance.address,
      '_id': instance.id,
      'owner': instance.owner,
      'category': categoryTypeToString(instance.category),
      'attributes': instance.attributes,
      'gallery': instance.gallery,
      'brandName': instance.brandName,
      'thumbnail': instance.thumbnail,
      'updatedAt': instance.updatedAt,
      'categoryImage': instance.categoryImage,
    };
