import 'package:client_tggt/model/review/review_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendors_get_list_review_response.g.dart';

@JsonSerializable()
class VendorsGetListReviewsResponse {
  @JsonKey(name: 'data')
  final VendorsGetListReviewsData? data;
  int? status;
  String? message;
  dynamic errors;

  VendorsGetListReviewsResponse({
    this.data,
    this.status,
    this.message,
    this.errors,
  });

  factory VendorsGetListReviewsResponse.fromJson(Map<String, dynamic> json) {
    return _$VendorsGetListReviewsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorsGetListReviewsResponseToJson(this);
}

@JsonSerializable()
class VendorsGetListReviewsData {
  final RatingModel ratings;
  final VendorsListReviewData reviews;
  VendorsGetListReviewsData({required this.ratings, required this.reviews});

  factory VendorsGetListReviewsData.fromJson(Map<String, dynamic> json) {
    return _$VendorsGetListReviewsDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorsGetListReviewsDataToJson(this);
}

@JsonSerializable()
class VendorsListReviewData {
  final List<ReviewModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  VendorsListReviewData(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory VendorsListReviewData.fromJson(Map<String, dynamic> json) {
    return _$VendorsListReviewDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorsListReviewDataToJson(this);
}
