import 'package:json_annotation/json_annotation.dart';

part 'thumbnail.g.dart';

@JsonSerializable()
class Thumbnail {
  @JsonKey(name: '_id')
  String? id;
  String? pathUrl;
  String? type;

  Thumbnail({this.id, this.pathUrl, this.type});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return _$ThumbnailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
