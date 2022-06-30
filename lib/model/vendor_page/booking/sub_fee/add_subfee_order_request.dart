import 'package:json_annotation/json_annotation.dart';

part 'add_subfee_order_request.g.dart';

@JsonSerializable()
class UpdateSubFeeOrderRequest {
  final List<UpdateSubFeeInOrderData> items;

  UpdateSubFeeOrderRequest({required this.items});

  factory UpdateSubFeeOrderRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateSubFeeOrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateSubFeeOrderRequestToJson(this);
}

@JsonSerializable()
class UpdateSubFeeInOrderData {
  final String name;
  final double price;
  final String? note;

  UpdateSubFeeInOrderData({required this.name, required this.price, this.note});

  factory UpdateSubFeeInOrderData.fromJson(Map<String, dynamic> json) {
    return _$UpdateSubFeeInOrderDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateSubFeeInOrderDataToJson(this);
}
