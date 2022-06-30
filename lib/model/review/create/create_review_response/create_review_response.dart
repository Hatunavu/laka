import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'create_review_response.g.dart';

@JsonSerializable()
class CreateReviewResponse {
  Data? data;
  int? status;
  String? message;
  dynamic errors;

  CreateReviewResponse({this.data, this.status, this.message, this.errors});

  factory CreateReviewResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateReviewResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateReviewResponseToJson(this);
}
