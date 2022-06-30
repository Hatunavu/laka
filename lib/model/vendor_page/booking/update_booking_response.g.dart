// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateBookingResponse _$UpdateBookingResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateBookingResponse(
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$UpdateBookingResponseToJson(
        UpdateBookingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
