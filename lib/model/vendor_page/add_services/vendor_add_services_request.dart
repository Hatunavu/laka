import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor_add_services_request.g.dart';

@JsonSerializable()
class VendorAddServicesRequest {
  final String name;
  final String details;
  final String? note;
  final int price;
  final List<AttributeModel> attributes;
  final bool? active;
  final String status;
  final String variantId;

  VendorAddServicesRequest(
      {required this.name,
      required this.details,
      required this.variantId,
      this.note,
      required this.price,
      required this.attributes,
      this.active,
      required this.status});

  factory VendorAddServicesRequest.fromJson(Map<String, dynamic> json) =>
      _$VendorAddServicesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VendorAddServicesRequestToJson(this);
}
