import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_staff_response.g.dart';

@JsonSerializable()
class CreateStaffResponse {
  int? status;
  String? message;
  dynamic errors;
  StaffModel? data;

  CreateStaffResponse({this.status, this.message, this.errors, this.data});

  factory CreateStaffResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateStaffResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateStaffResponseToJson(this);
}
