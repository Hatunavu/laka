import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'list_review_response.g.dart';

@JsonSerializable()
class ListReviewResponse {
  Data? data;
  int? status;
  String? message;
  dynamic errors;

  ListReviewResponse({this.data, this.status, this.message, this.errors});

  factory ListReviewResponse.fromJson(Map<String, dynamic> json) {
    return _$ListReviewResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListReviewResponseToJson(this);
}
