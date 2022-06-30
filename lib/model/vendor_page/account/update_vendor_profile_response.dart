import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_vendor_profile_response.g.dart';

@JsonSerializable()
class UpdateVendorProfileResponse {
  final int status;
  final String message;
  final VendorModel? data;

  UpdateVendorProfileResponse(
      {required this.status, required this.message, this.data});

  factory UpdateVendorProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateVendorProfileResponseFromJson(json);
}
