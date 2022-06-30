import 'package:json_annotation/json_annotation.dart';

import 'product.dart';
import 'product_option.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  Product? product;
  List<ProductOption>? productOptions;
  String? vendor;
  String? productId;
  String? customer;
  double? totalPrice;
  int? totalPeople;
  String? note;
  String? orderAt;

  Data({
    this.product,
    this.productOptions,
    this.vendor,
    this.productId,
    this.customer,
    this.totalPrice,
    this.totalPeople,
    this.note,
    this.orderAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
