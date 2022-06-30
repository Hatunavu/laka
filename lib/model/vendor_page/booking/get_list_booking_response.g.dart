// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListBookingResponse _$GetListBookingResponseFromJson(
        Map<String, dynamic> json) =>
    GetListBookingResponse(
      data: json['data'] == null
          ? null
          : ListBooking.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetListBookingResponseToJson(
        GetListBookingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListBooking _$ListBookingFromJson(Map<String, dynamic> json) => ListBooking(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => BookingItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListBookingToJson(ListBooking instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
