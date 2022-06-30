import 'package:json_annotation/json_annotation.dart';

part 'update_vendor_profile_request.g.dart';

@JsonSerializable()
class UpdateVendorProfileRequest {
  final String? brandName;
  final String? details;
  final double? lat;
  final double? lng;

  UpdateVendorProfileRequest(
      {this.brandName, this.details, this.lat, this.lng});
  factory UpdateVendorProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVendorProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateVendorProfileRequestToJson(this);
}
