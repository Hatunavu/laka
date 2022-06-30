// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListNotificationResponse _$GetListNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    GetListNotificationResponse(
      data: ListNotification.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetListNotificationResponseToJson(
        GetListNotificationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListNotification _$ListNotificationFromJson(Map<String, dynamic> json) =>
    ListNotification(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => NotificationModal.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListNotificationToJson(ListNotification instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
