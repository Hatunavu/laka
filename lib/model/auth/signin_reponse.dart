import 'package:client_tggt/model/user/user_session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signin_reponse.g.dart';

@JsonSerializable()
class SigninResponse {
  @JsonKey(name: 'data')
  final UserSession? userSession;
  final int status;
  final String message;

  SigninResponse({
    this.userSession,
    required this.status,
    required this.message,
  });

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);
}
