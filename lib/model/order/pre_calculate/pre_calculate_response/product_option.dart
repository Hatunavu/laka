import 'package:json_annotation/json_annotation.dart';

import 'option.dart';

part 'product_option.g.dart';

@JsonSerializable()
class ProductOption {
  Option? option;
  int? amount;

  ProductOption({this.option, this.amount});

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return _$ProductOptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductOptionToJson(this);
}
