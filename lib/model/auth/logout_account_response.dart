import 'package:json_annotation/json_annotation.dart';

part 'logout_account_response.g.dart';

@JsonSerializable()
class LogoutAccountResponse {
  final int status;
  final String message;

  LogoutAccountResponse({
    required this.status,
    required this.message,
  });

  factory LogoutAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutAccountResponseFromJson(json);
}
