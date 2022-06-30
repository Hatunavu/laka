import 'package:json_annotation/json_annotation.dart';

part 'complete_register_response.g.dart';

@JsonSerializable()
class CompleteRegisterResponse {
  final int status;
  final String message;

  CompleteRegisterResponse({
    required this.status,
    required this.message,
  });

  factory CompleteRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$CompleteRegisterResponseFromJson(json);
}
