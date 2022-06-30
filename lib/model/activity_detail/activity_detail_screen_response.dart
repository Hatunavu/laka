import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'activity_detail_screen_response.g.dart';

@JsonSerializable()
class ActivityDetailScreenResponse {
  BookingItemModel? data;
  int? status;
  String? message;
  dynamic errors;

  ActivityDetailScreenResponse({
    this.data,
    this.status,
    this.message,
    this.errors,
  });

  factory ActivityDetailScreenResponse.fromJson(Map<String, dynamic> json) {
    return _$ActivityDetailScreenResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityDetailScreenResponseToJson(this);
}
