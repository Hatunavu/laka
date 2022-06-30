import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? details;
  List<dynamic>? gallery;
  int? price;
  bool? active;
  String? status;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.details,
    this.gallery,
    this.price,
    this.active,
    this.status,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
