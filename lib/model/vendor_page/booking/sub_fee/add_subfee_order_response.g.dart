// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_subfee_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateSubFeeOrderResponse _$UpdateSubFeeOrderResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateSubFeeOrderResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateSubFeeOrderResponseToJson(
        UpdateSubFeeOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
