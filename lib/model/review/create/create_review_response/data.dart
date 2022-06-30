import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  final String? content;
  final String? order;
  final String? vendor;
  final String? reviewer;
  final int? rating;
  final List<Gallery>? gallery;
  @JsonKey(name: '_id')
  final String? id;

  Data({
    this.content,
    this.order,
    this.vendor,
    this.reviewer,
    this.rating,
    this.gallery,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Gallery {
  String? path;
  String? type;
  @JsonKey(name: '_id')
  String? id;

  Gallery({this.path, this.type, this.id});

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return _$GalleryFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GalleryToJson(this);
}
