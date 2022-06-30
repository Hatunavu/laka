// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_get_list_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminGetListOrdersReponse _$AdminGetListOrdersReponseFromJson(
        Map<String, dynamic> json) =>
    AdminGetListOrdersReponse(
      data: GetListOrdersData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AdminGetListOrdersReponseToJson(
        AdminGetListOrdersReponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

GetListOrdersData _$GetListOrdersDataFromJson(Map<String, dynamic> json) =>
    GetListOrdersData(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => BookingItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$GetListOrdersDataToJson(GetListOrdersData instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
