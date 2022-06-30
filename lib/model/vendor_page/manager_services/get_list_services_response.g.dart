// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListServicesResponse _$GetListServicesResponseFromJson(
        Map<String, dynamic> json) =>
    GetListServicesResponse(
      data: json['data'] == null
          ? null
          : ListServicesDocs.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$GetListServicesResponseToJson(
        GetListServicesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

ListServicesDocs _$ListServicesDocsFromJson(Map<String, dynamic> json) =>
    ListServicesDocs(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => ServicesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
    );

Map<String, dynamic> _$ListServicesDocsToJson(ListServicesDocs instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
    };
