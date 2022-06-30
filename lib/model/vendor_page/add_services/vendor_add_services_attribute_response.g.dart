// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_add_services_attribute_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorAddServicesAttributeResponse _$VendorAddServicesAttributeResponseFromJson(
        Map<String, dynamic> json) =>
    VendorAddServicesAttributeResponse(
      data: json['data'] == null
          ? null
          : DefaultAndVendorAttribute.fromJson(
              json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorAddServicesAttributeResponseToJson(
        VendorAddServicesAttributeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

DefaultAndVendorAttribute _$DefaultAndVendorAttributeFromJson(
        Map<String, dynamic> json) =>
    DefaultAndVendorAttribute(
      defaultAttributes: (json['defaultAttributes'] as List<dynamic>)
          .map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      vendorAttributes: (json['vendorAttributes'] as List<dynamic>)
          .map((e) => AttributeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DefaultAndVendorAttributeToJson(
        DefaultAndVendorAttribute instance) =>
    <String, dynamic>{
      'defaultAttributes': instance.defaultAttributes,
      'vendorAttributes': instance.vendorAttributes,
    };
