import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_update_response.g.dart';

@JsonSerializable()
class ForgotPasswordUpdateReponse {
  final int status;
  final String message;

  ForgotPasswordUpdateReponse({
    required this.status,
    required this.message,
  });

  factory ForgotPasswordUpdateReponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordUpdateReponseFromJson(json);
}
