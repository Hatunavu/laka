import 'package:json_annotation/json_annotation.dart';

part 'cancel_order_response.g.dart';

@JsonSerializable()
class CancelOrderResponse {
  dynamic data;
  int? status;
  String? message;
  dynamic errors;

  CancelOrderResponse({this.data, this.status, this.message, this.errors});

  factory CancelOrderResponse.fromJson(Map<String, dynamic> json) {
    return _$CancelOrderResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CancelOrderResponseToJson(this);
}
