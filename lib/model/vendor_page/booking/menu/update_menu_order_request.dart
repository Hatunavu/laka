import 'package:json_annotation/json_annotation.dart';

part 'update_menu_order_request.g.dart';

@JsonSerializable()
class UpdateMenuInOrderRequest {
  final List<UpdateMenuInOrderData> items;

  UpdateMenuInOrderRequest({required this.items});

  factory UpdateMenuInOrderRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateMenuInOrderRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateMenuInOrderRequestToJson(this);
}

@JsonSerializable()
class UpdateMenuInOrderData {
  final String id;
  final int amount;

  UpdateMenuInOrderData({required this.id, required this.amount});

  factory UpdateMenuInOrderData.fromJson(Map<String, dynamic> json) {
    return _$UpdateMenuInOrderDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UpdateMenuInOrderDataToJson(this);
}
