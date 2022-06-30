import 'package:json_annotation/json_annotation.dart';

part 'add_decive_token_response.g.dart';

@JsonSerializable()
class AddDeceiveTokenResponse {
  final int status;
  final String message;

  AddDeceiveTokenResponse({
    required this.status,
    required this.message,
  });

  factory AddDeceiveTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$AddDeceiveTokenResponseFromJson(json);
}
