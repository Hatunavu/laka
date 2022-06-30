import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_vendor_response.g.dart';

@JsonSerializable()
class CreateVendorResponse {
  VendorInfoModel? data;
  int? status;
  String? message;
  dynamic errors;

  CreateVendorResponse({this.data, this.status, this.message, this.errors});

  factory CreateVendorResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateVendorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateVendorResponseToJson(this);
}
