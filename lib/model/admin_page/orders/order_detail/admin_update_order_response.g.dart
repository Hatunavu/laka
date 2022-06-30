// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminUpdateOrdersResponse _$AdminUpdateOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    AdminUpdateOrdersResponse(
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$AdminUpdateOrdersResponseToJson(
        AdminUpdateOrdersResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
