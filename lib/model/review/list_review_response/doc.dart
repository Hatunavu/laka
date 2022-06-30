import 'package:json_annotation/json_annotation.dart';

import 'gallery.dart';
import 'reviewer.dart';

part 'doc.g.dart';

@JsonSerializable()
class Doc {
  @JsonKey(name: '_id')
  String? id;
  String? content;
  String? vendor;
  Reviewer? reviewer;
  double? rating;
  List<GalleryModel>? gallery;
  String? createdAt;
  String? updatedAt;

  Doc({
    this.id,
    this.content,
    this.vendor,
    this.reviewer,
    this.rating,
    this.gallery,
    this.createdAt,
    this.updatedAt,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => _$DocFromJson(json);

  Map<String, dynamic> toJson() => _$DocToJson(this);
}
