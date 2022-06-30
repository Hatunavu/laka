// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_list_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListPostResponse _$GetListPostResponseFromJson(Map<String, dynamic> json) =>
    GetListPostResponse(
      data: ListPost.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetListPostResponseToJson(
        GetListPostResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

ListPost _$ListPostFromJson(Map<String, dynamic> json) => ListPost(
      docs: (json['docs'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$ListPostToJson(ListPost instance) => <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
