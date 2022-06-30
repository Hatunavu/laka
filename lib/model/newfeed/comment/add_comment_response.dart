import 'package:client_tggt/model/newfeed/comment/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_comment_response.g.dart';

@JsonSerializable()
class AddCommentResponse {
  @JsonKey(name: 'data')
  final AddCommentData data;
  final int status;
  final String? message;

  AddCommentResponse({required this.data, required this.status, this.message});
  factory AddCommentResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentResponseToJson(this);
}

@JsonSerializable()
class AddCommentData {
  final AddCommentDataPost? post;
  final CommentItem comment;

  AddCommentData({this.post, required this.comment});
  factory AddCommentData.fromJson(Map<String, dynamic> json) =>
      _$AddCommentDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentDataToJson(this);
}

@JsonSerializable()
class AddCommentDataPost {
  @JsonKey(name: '_id')
  final String? id;
  final int? totalComments;

  AddCommentDataPost({this.id, this.totalComments});
  factory AddCommentDataPost.fromJson(Map<String, dynamic> json) =>
      _$AddCommentDataPostFromJson(json);

  Map<String, dynamic> toJson() => _$AddCommentDataPostToJson(this);
}
