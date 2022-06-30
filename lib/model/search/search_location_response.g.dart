// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationResponse _$SearchLocationResponseFromJson(
        Map<String, dynamic> json) =>
    SearchLocationResponse(
      data: json['data'] == null
          ? null
          : ListVendor.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$SearchLocationResponseToJson(
        SearchLocationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

ListVendor _$ListVendorFromJson(Map<String, dynamic> json) => ListVendor(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => VendorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListVendorToJson(ListVendor instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
