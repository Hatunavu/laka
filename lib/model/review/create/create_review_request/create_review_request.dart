import 'package:json_annotation/json_annotation.dart';

part 'create_review_request.g.dart';

@JsonSerializable()
class CreateReviewRequest {
  String? content;
  double? rating;
  List<String>? gallery;

  CreateReviewRequest({
    this.content,
    this.rating,
    this.gallery,
  });

  factory CreateReviewRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateReviewRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateReviewRequestToJson(this);
}
