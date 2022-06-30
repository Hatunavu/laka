import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_menu_response.g.dart';

@JsonSerializable()
class CreateMenuResponse {
  int? status;
  String? message;
  dynamic errors;
  MenuModel? data;

  CreateMenuResponse({this.status, this.message, this.errors, this.data});

  factory CreateMenuResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateMenuResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateMenuResponseToJson(this);
}
