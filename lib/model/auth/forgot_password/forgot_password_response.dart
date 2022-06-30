import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordReponse {
  final int status;
  final String message;

  ForgotPasswordReponse({
    required this.status,
    required this.message,
  });

  factory ForgotPasswordReponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordReponseFromJson(json);
}
