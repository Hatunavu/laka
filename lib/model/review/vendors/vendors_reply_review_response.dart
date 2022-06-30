import 'package:client_tggt/model/review/review_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendors_reply_review_response.g.dart';

@JsonSerializable()
class VendorsReplyReviewResponse {
  @JsonKey(name: 'data')
  final ReviewModel? data;
  final int status;
  final String message;

  VendorsReplyReviewResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory VendorsReplyReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorsReplyReviewResponseFromJson(json);
}
