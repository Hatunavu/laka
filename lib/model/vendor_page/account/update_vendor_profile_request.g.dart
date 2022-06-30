// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_vendor_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateVendorProfileRequest _$UpdateVendorProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateVendorProfileRequest(
      brandName: json['brandName'] as String?,
      details: json['details'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UpdateVendorProfileRequestToJson(
        UpdateVendorProfileRequest instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'details': instance.details,
      'lat': instance.lat,
      'lng': instance.lng,
    };
