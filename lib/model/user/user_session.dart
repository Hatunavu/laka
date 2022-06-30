import 'package:client_tggt/model/user/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_session.g.dart';

@JsonSerializable()
class UserSession {
  final String token;
  final AccountModel account;
  final String userId;

  UserSession(
      {required this.token, required this.account, required this.userId});

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);
}
