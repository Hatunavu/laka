import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_vendors_thubnail_response.g.dart';

@JsonSerializable()
class UpdateVendorsThumbnailResponse {
  @JsonKey(name: 'data')
  final VendorThumbnail? data;
  final int status;
  final String message;

  UpdateVendorsThumbnailResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory UpdateVendorsThumbnailResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateVendorsThumbnailResponseFromJson(json);
}
