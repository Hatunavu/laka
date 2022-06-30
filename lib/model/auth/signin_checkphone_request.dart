import 'package:json_annotation/json_annotation.dart';

part 'signin_checkphone_request.g.dart';

@JsonSerializable()
class SigninCheckPhoneRequest {
  final String phone;

  SigninCheckPhoneRequest({required this.phone});
  factory SigninCheckPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninCheckPhoneRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SigninCheckPhoneRequestToJson(this);
}
