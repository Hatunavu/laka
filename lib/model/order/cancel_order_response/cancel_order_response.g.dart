// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelOrderResponse _$CancelOrderResponseFromJson(Map<String, dynamic> json) =>
    CancelOrderResponse(
      data: json['data'],
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$CancelOrderResponseToJson(
        CancelOrderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
