import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_update_request.g.dart';

@JsonSerializable()
class ForgotPasswordUpdateRequest {
  final String password;

  ForgotPasswordUpdateRequest({
    required this.password,
  });
  factory ForgotPasswordUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPasswordUpdateRequestToJson(this);
}
