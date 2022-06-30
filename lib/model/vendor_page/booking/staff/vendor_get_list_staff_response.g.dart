// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_get_list_staff_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorsGetListStaffResponse _$VendorsGetListStaffResponseFromJson(
        Map<String, dynamic> json) =>
    VendorsGetListStaffResponse(
      data: ListStaffData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorsGetListStaffResponseToJson(
        VendorsGetListStaffResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListStaffData _$ListStaffDataFromJson(Map<String, dynamic> json) =>
    ListStaffData(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => StaffModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListStaffDataToJson(ListStaffData instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
