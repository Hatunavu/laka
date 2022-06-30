import 'package:json_annotation/json_annotation.dart';

part 'gallery.g.dart';

@JsonSerializable()
class Gallery {
  String? path;
  String? type;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;

  Gallery({this.path, this.type, this.id, this.createdAt, this.updatedAt});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return _$GalleryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GalleryToJson(this);
}
