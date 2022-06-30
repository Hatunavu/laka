import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@JsonSerializable()
class Thumbnail {
  String? path;
  String? type;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;

  Thumbnail({
    this.path,
    this.type,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return _$ThumbnailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
