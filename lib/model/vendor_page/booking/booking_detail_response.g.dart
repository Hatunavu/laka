// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookingDetailResponse _$GetBookingDetailResponseFromJson(
        Map<String, dynamic> json) =>
    GetBookingDetailResponse(
      data: json['data'] == null
          ? null
          : BookingItemModel.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetBookingDetailResponseToJson(
        GetBookingDetailResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };
