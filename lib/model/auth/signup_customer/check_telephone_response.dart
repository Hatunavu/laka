import 'package:json_annotation/json_annotation.dart';

part 'check_telephone_response.g.dart';

@JsonSerializable()
class CheckTelephoneResponse {
  final int status;
  final String message;

  CheckTelephoneResponse({
    required this.status,
    required this.message,
  });

  factory CheckTelephoneResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckTelephoneResponseFromJson(json);
}
