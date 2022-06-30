import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vendors_screen_response.g.dart';

@JsonSerializable()
class VendorsScreenResponse {
  final VendorsScreenResponseData data;
  final int status;
  final String message;

  VendorsScreenResponse(
      {required this.data, required this.status, required this.message});

  factory VendorsScreenResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorsScreenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsScreenResponseToJson(this);
}

@JsonSerializable()
class VendorsScreenResponseData {
  final List<VendorModel> hotVendors;
  final List<VendorModel> suggestedVendors;
  VendorsScreenResponseData(
      {required this.hotVendors, required this.suggestedVendors});

  factory VendorsScreenResponseData.fromJson(Map<String, dynamic> json) =>
      _$VendorsScreenResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsScreenResponseDataToJson(this);
}
