// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListMessageResponse _$GetListMessageResponseFromJson(
        Map<String, dynamic> json) =>
    GetListMessageResponse(
      data: GetListMessageDocs.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetListMessageResponseToJson(
        GetListMessageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

GetListMessageDocs _$GetListMessageDocsFromJson(Map<String, dynamic> json) =>
    GetListMessageDocs(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => MessageItemInList.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$GetListMessageDocsToJson(GetListMessageDocs instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };

MessageItemInList _$MessageItemInListFromJson(Map<String, dynamic> json) =>
    MessageItemInList(
      id: json['_id'] as String,
      vendor: json['vendor'] == null
          ? null
          : VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
      orderId: json['orderId'] as String?,
      message: json['message'] as String?,
      by: json['by'] == null
          ? null
          : AccountModel.fromJson(json['by'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : AccountModel.fromJson(json['customer'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MessageItemInListToJson(MessageItemInList instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'vendor': instance.vendor,
      'orderId': instance.orderId,
      'message': instance.message,
      'by': instance.by,
      'customer': instance.customer,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
