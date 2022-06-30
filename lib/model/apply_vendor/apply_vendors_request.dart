import 'package:json_annotation/json_annotation.dart';

part 'apply_vendors_request.g.dart';

@JsonSerializable()
class ApplyVendorsRequest {
  final String brandName;
  final String fullName;
  final String fullAddress;
  final String phone;
  final String email;

  ApplyVendorsRequest({
    required this.brandName,
    required this.fullName,
    required this.fullAddress,
    required this.email,
    required this.phone,
  });

  factory ApplyVendorsRequest.fromJson(Map<String, dynamic> json) {
    return _$ApplyVendorsRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApplyVendorsRequestToJson(this);
}
