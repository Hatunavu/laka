// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_filter_vendor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFilterVendorReponse _$GetFilterVendorReponseFromJson(
        Map<String, dynamic> json) =>
    GetFilterVendorReponse(
      data: FilterVendorData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetFilterVendorReponseToJson(
        GetFilterVendorReponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

FilterVendorData _$FilterVendorDataFromJson(Map<String, dynamic> json) =>
    FilterVendorData(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$FilterVendorDataToJson(FilterVendorData instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
