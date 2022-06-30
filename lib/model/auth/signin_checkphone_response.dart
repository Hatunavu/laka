import 'package:json_annotation/json_annotation.dart';

part 'signin_checkphone_response.g.dart';

@JsonSerializable()
class SigninCheckPhoneResponse {
  final int status;
  final String message;

  SigninCheckPhoneResponse({
    required this.status,
    required this.message,
  });

  factory SigninCheckPhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninCheckPhoneResponseFromJson(json);
}
