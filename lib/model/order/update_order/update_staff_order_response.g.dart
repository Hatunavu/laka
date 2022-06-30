// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_staff_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStaffOrderResponse _$UpdateStaffOrderResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateStaffOrderResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateStaffOrderResponseToJson(
        UpdateStaffOrderResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
      'data': instance.data,
    };
