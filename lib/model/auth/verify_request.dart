import 'package:json_annotation/json_annotation.dart';

part 'verify_request.g.dart';

@JsonSerializable()
class VerifyRequest {
  final String phone;
  final String code;

  VerifyRequest({required this.phone, required this.code});
  factory VerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyRequestToJson(this);
}
