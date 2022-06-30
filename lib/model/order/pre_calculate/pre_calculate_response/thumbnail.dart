import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@JsonSerializable()
class Thumbnail {
  String? path;
  String? type;
  @JsonKey(name: '_id')
  String? id;
  String? updatedAt;
  String? createdAt;

  Thumbnail({
    this.path,
    this.type,
    this.id,
    this.updatedAt,
    this.createdAt,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return _$ThumbnailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
