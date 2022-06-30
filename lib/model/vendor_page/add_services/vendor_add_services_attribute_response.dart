import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor_add_services_attribute_response.g.dart';

@JsonSerializable()
class VendorAddServicesAttributeResponse {
  @JsonKey(name: 'data')
  final DefaultAndVendorAttribute? data;
  final int status;
  final String message;
  final dynamic errors;

  VendorAddServicesAttributeResponse(
      {this.data, required this.status, required this.message, this.errors});

  factory VendorAddServicesAttributeResponse.fromJson(
          Map<String, dynamic> json) =>
      _$VendorAddServicesAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$VendorAddServicesAttributeResponseToJson(this);
}

@JsonSerializable()
class DefaultAndVendorAttribute {
  final List<AttributeModel> defaultAttributes;
  final List<AttributeModel> vendorAttributes;
  DefaultAndVendorAttribute(
      {required this.defaultAttributes, required this.vendorAttributes});

  factory DefaultAndVendorAttribute.fromJson(Map<String, dynamic> json) =>
      _$DefaultAndVendorAttributeFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultAndVendorAttributeToJson(this);
}
