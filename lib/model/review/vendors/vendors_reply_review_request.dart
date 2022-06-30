import 'package:json_annotation/json_annotation.dart';

part 'vendors_reply_review_request.g.dart';

@JsonSerializable()
class VendorsReplyReviewRequest {
  final String content;

  VendorsReplyReviewRequest({required this.content});
  factory VendorsReplyReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$VendorsReplyReviewRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VendorsReplyReviewRequestToJson(this);
}
