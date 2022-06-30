// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_menu_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMenuOrderResponse _$UpdateMenuOrderResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateMenuOrderResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateMenuOrderResponseToJson(
        UpdateMenuOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
