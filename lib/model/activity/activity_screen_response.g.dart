// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_screen_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityScreenResponse _$ActivityScreenResponseFromJson(
        Map<String, dynamic> json) =>
    ActivityScreenResponse(
      data: json['data'] == null
          ? null
          : DataListActivity.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$ActivityScreenResponseToJson(
        ActivityScreenResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

DataListActivity _$DataListActivityFromJson(Map<String, dynamic> json) =>
    DataListActivity(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => BookingItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
      hasPrevPage: json['hasPrevPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      prevPage: json['prevPage'],
      nextPage: json['nextPage'],
      totalOrderActive: json['totalOrderActive'] as int?,
      waitingReviews: json['waitingReviews'] as int?,
    );

Map<String, dynamic> _$DataListActivityToJson(DataListActivity instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
      'hasPrevPage': instance.hasPrevPage,
      'hasNextPage': instance.hasNextPage,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
      'totalOrderActive': instance.totalOrderActive,
      'waitingReviews': instance.waitingReviews,
    };
