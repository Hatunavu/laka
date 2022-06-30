import 'package:client_tggt/model/category/enum_category.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
import 'gallery.dart';
import 'thumbnail.dart';

part 'vendor.g.dart';

@JsonSerializable()
class Vendor {
  Address? address;
  @JsonKey(name: '_id')
  String? id;
  String? owner;
  @JsonKey(
    name: 'category',
    fromJson: stringToCategoryType,
    toJson: categoryTypeToString,
  )
  CategoryType category;
  List<String>? attributes;
  List<Gallery>? gallery;
  String? brandName;
  Thumbnail? thumbnail;
  String? updatedAt;
  String? categoryImage;

  Vendor({
    this.address,
    this.id,
    this.owner,
    required this.category,
    this.attributes,
    this.gallery,
    this.brandName,
    this.thumbnail,
    this.updatedAt,
    this.categoryImage,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return _$VendorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
