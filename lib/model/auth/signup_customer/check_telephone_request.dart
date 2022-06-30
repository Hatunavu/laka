import 'package:json_annotation/json_annotation.dart';

part 'check_telephone_request.g.dart';

@JsonSerializable()
class CheckTelephoneRequest {
  final String phone;
  final String referralBy;
  final String fullName;

  CheckTelephoneRequest(
      {required this.phone, required this.referralBy, required this.fullName});
  factory CheckTelephoneRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckTelephoneRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CheckTelephoneRequestToJson(this);
}
