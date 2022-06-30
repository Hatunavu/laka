import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendors_category_response.g.dart';

@JsonSerializable()
class VendorListCategoryResponse {
  @JsonKey(name: 'data')
  final List<VendorModel>? data;
  final int status;
  final String? message;

  VendorListCategoryResponse({
    this.data,
    required this.status,
    this.message,
  });

  factory VendorListCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorListCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorListCategoryResponseToJson(this);
}
