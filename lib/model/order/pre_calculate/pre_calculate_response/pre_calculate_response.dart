import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'pre_calculate_response.g.dart';

@JsonSerializable()
class PreCalculateResponse {
  final BookingItemModel? data;
  int? status;
  String? message;
  dynamic errors;

  PreCalculateResponse({this.data, this.status, this.message, this.errors});

  factory PreCalculateResponse.fromJson(Map<String, dynamic> json) {
    return _$PreCalculateResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PreCalculateResponseToJson(this);
}
