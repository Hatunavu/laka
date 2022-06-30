import 'package:client_tggt/model/newfeed/comment/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_more_comment_response.g.dart';

@JsonSerializable()
class GetMoreCommentResponse {
  @JsonKey(name: 'data')
  final CommentData data;
  final int status;
  final String? message;

  GetMoreCommentResponse(
      {required this.data, required this.status, this.message});
  factory GetMoreCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMoreCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetMoreCommentResponseToJson(this);
}

@JsonSerializable()
class CommentData {
  final List<CommentItem> docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;
  CommentData(
      {required this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});
  factory CommentData.fromJson(Map<String, dynamic> json) =>
      _$CommentDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentDataToJson(this);
}
