import 'package:json_annotation/json_annotation.dart';

part 'create_vendor_request.g.dart';

@JsonSerializable()
class CreateVendorRequest {
  final String brandName;
  final String details;
  final String category;
  final String? fullAddress;
  final List<String>? attributes;
  final List<String> gallery;
  final String lat;
  final String lng;

  CreateVendorRequest(
      {required this.brandName,
      required this.details,
      required this.category,
      this.fullAddress,
      this.attributes,
      required this.gallery,
      required this.lat,
      required this.lng});

  factory CreateVendorRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateVendorRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateVendorRequestToJson(this);
}
