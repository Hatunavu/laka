import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attribute.dart';
import 'thumbnail.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  VendorModel? vendor;
  String? details;
  Thumbnail? thumbnail;
  int? price;
  List<Attribute>? attributes;
  bool? active;
  String? status;
  int? quantity;
  List<dynamic>? gallery;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.vendor,
    this.details,
    this.thumbnail,
    this.price,
    this.attributes,
    this.active,
    this.status,
    this.quantity,
    this.gallery,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
