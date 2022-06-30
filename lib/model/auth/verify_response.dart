import 'package:client_tggt/model/user/user_session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_response.g.dart';

@JsonSerializable()
class VerifyResponse {
  @JsonKey(name: 'data')
  final UserSession? userSession;
  final int status;
  final String message;

  VerifyResponse({
    this.userSession,
    required this.status,
    required this.message,
  });

  factory VerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseFromJson(json);
}
