import 'package:json_annotation/json_annotation.dart';

part 'add_comment_request.g.dart';

@JsonSerializable()
class AddCommentRequest {
  final String? content;
  final List<String>? media;
  final String? parent;

  AddCommentRequest({this.content, this.media, this.parent});

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) {
    return _$AddCommentRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddCommentRequestToJson(this);
}
