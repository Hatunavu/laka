import 'package:json_annotation/json_annotation.dart';

part 'signin_telephone_request.g.dart';

@JsonSerializable()
class SigninTelephoneRequest {
  final String phone;
  final String code;

  SigninTelephoneRequest({required this.phone, required this.code});
  factory SigninTelephoneRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninTelephoneRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SigninTelephoneRequestToJson(this);
}
