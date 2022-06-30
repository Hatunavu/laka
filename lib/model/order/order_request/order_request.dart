import 'package:json_annotation/json_annotation.dart';

import 'option.dart';

part 'order_request.g.dart';

@JsonSerializable()
class OrderRequest {
  String? productId;
  int? totalPeople;
  String? note;
  String? orderAt;
  List<Option>? options;
  final String? voucherId;

  OrderRequest(
      {this.productId,
      this.totalPeople,
      this.note,
      this.orderAt,
      this.options,
      this.voucherId});

  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    return _$OrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}
