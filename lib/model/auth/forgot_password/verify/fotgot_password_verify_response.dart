import 'package:json_annotation/json_annotation.dart';

part 'fotgot_password_verify_response.g.dart';

@JsonSerializable()
class ForgotPasswordVerifyResponse {
  @JsonKey(name: 'data')
  final ForgotPasswordVerifyData? data;
  final int status;
  final String message;

  ForgotPasswordVerifyResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory ForgotPasswordVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordVerifyResponseFromJson(json);
}

@JsonSerializable()
class ForgotPasswordVerifyData {
  final String token;

  ForgotPasswordVerifyData({
    required this.token,
  });

  factory ForgotPasswordVerifyData.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordVerifyDataFromJson(json);
}
