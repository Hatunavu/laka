// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_more_comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMoreCommentResponse _$GetMoreCommentResponseFromJson(
        Map<String, dynamic> json) =>
    GetMoreCommentResponse(
      data: CommentData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetMoreCommentResponseToJson(
        GetMoreCommentResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
    };

CommentData _$CommentDataFromJson(Map<String, dynamic> json) => CommentData(
      docs: (json['docs'] as List<dynamic>)
          .map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int?,
      limit: json['limit'] as int?,
      totalPage: json['totalPage'] as int?,
      page: json['page'] as int?,
      pagingCounter: json['pagingCounter'] as int?,
    );

Map<String, dynamic> _$CommentDataToJson(CommentData instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'totalDocs': instance.totalDocs,
      'limit': instance.limit,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
    };
