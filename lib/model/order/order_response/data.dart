import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Product? product;
  String? vendor;
  String? productId;
  String? customer;
  int? totalPeople;
  String? status;
  String? orderAt;
  String? note;
  int? totalPrice;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;
  String? orderId;

  Data({
    this.product,
    this.vendor,
    this.productId,
    this.customer,
    this.totalPeople,
    this.status,
    this.orderAt,
    this.note,
    this.totalPrice,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
