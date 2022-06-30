// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_menu_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorGetListMenuResponse _$VendorGetListMenuResponseFromJson(
        Map<String, dynamic> json) =>
    VendorGetListMenuResponse(
      data: ListMenudata.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorGetListMenuResponseToJson(
        VendorGetListMenuResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListMenudata _$ListMenudataFromJson(Map<String, dynamic> json) => ListMenudata(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => MenuModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListMenudataToJson(ListMenudata instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
