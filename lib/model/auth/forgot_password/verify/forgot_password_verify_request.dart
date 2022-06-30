import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_verify_request.g.dart';

@JsonSerializable()
class ForgotPasswordVerifyRequest {
  final String phone;
  final String code;

  ForgotPasswordVerifyRequest({
    required this.phone,
    required this.code,
  });
  factory ForgotPasswordVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordVerifyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordVerifyRequestToJson(this);
}
