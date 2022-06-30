// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendors_create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsCreateOrderResponse _$VendorsCreateOrderResponseFromJson(
        Map<String, dynamic> json) =>
    VendorsCreateOrderResponse(
      data: json['data'] as String?,
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorsCreateOrderResponseToJson(
        VendorsCreateOrderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
