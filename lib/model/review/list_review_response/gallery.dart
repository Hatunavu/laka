import 'package:json_annotation/json_annotation.dart';
part 'gallery.g.dart';

@JsonSerializable()
class GalleryModel {
  GalleryModel({this.id, this.path, this.type, this.pathUrl});
  @JsonKey(name: '_id')
  final String? id;
  final String? path;
  final String? type;
  final String? pathUrl;

  factory GalleryModel.fromJson(Map<String, dynamic> json) =>
      _$GalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);
}
