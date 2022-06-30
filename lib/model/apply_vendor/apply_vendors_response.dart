import 'package:json_annotation/json_annotation.dart';

part 'apply_vendors_response.g.dart';

@JsonSerializable()
class ApplyVendorResponse {
  int? status;
  String? message;
  dynamic errors;

  ApplyVendorResponse({this.status, this.message, this.errors});

  factory ApplyVendorResponse.fromJson(Map<String, dynamic> json) {
    return _$ApplyVendorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApplyVendorResponseToJson(this);
}
