import 'package:client_tggt/model/review/list_review_response/gallery.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? content;
  final AccountModel? reviewer;
  final double? rating;
  final String? createdAt;
  final List<GalleryModel>? gallery;

  ReviewModel({
    this.createdAt,
    this.id,
    this.content,
    this.reviewer,
    this.rating,
    this.gallery,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
