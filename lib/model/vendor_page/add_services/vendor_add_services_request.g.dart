// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_add_services_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorAddServicesRequest _$VendorAddServicesRequestFromJson(
        Map<String, dynamic> json) =>
    VendorAddServicesRequest(
      name: json['name'] as String,
      details: json['details'] as String,
      variantId: json['variantId'] as String,
      note: json['note'] as String?,
      price: json['price'] as int,
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      active: json['active'] as bool?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$VendorAddServicesRequestToJson(
        VendorAddServicesRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'details': instance.details,
      'note': instance.note,
      'price': instance.price,
      'attributes': instance.attributes,
      'active': instance.active,
      'status': instance.status,
      'variantId': instance.variantId,
    };
