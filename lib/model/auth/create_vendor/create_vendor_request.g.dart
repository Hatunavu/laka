// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_vendor_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateVendorRequest _$CreateVendorRequestFromJson(Map<String, dynamic> json) =>
    CreateVendorRequest(
      brandName: json['brandName'] as String,
      details: json['details'] as String,
      category: json['category'] as String,
      fullAddress: json['fullAddress'] as String?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      gallery:
          (json['gallery'] as List<dynamic>).map((e) => e as String).toList(),
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );

Map<String, dynamic> _$CreateVendorRequestToJson(
        CreateVendorRequest instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'details': instance.details,
      'category': instance.category,
      'fullAddress': instance.fullAddress,
      'attributes': instance.attributes,
      'gallery': instance.gallery,
      'lat': instance.lat,
      'lng': instance.lng,
    };
