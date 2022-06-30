// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_voucher_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListVoucherResponse _$GetListVoucherResponseFromJson(
        Map<String, dynamic> json) =>
    GetListVoucherResponse(
      data: json['data'] == null
          ? null
          : ListVoucherData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetListVoucherResponseToJson(
        GetListVoucherResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListVoucherData _$ListVoucherDataFromJson(Map<String, dynamic> json) =>
    ListVoucherData(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => VoucherModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListVoucherDataToJson(ListVoucherData instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
