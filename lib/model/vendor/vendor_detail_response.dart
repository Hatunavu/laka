import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vendor_detail_response.g.dart';

@JsonSerializable()
class VendorDetailResponse {
  @JsonKey(name: 'data')
  final VendorModel? vendorItem;
  final int status;
  final String? message;
  final dynamic errors;

  VendorDetailResponse(
      {this.vendorItem, required this.status, this.message, this.errors});
  factory VendorDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDetailResponseToJson(this);
}
