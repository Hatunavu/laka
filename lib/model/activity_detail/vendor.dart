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
  String? category;
  List<String>? attributes;
  List<Gallery>? gallery;
  String? brandName;
  Thumbnail? thumbnail;
  String? updatedAt;
  String? categoryImage;
  Vendor? vendor;

  Vendor({
    this.address,
    this.id,
    this.owner,
    this.category,
    this.attributes,
    this.gallery,
    this.brandName,
    this.thumbnail,
    this.updatedAt,
    this.categoryImage,
    this.vendor,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return _$VendorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
