import 'package:json_annotation/json_annotation.dart';

part 'add_deceive_token_request.g.dart';

@JsonSerializable()
class AddDeceiveTokenRequest {
  final String deviceToken;
  final String deviceType;

  AddDeceiveTokenRequest({
    required this.deviceToken,
    required this.deviceType,
  });
  factory AddDeceiveTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$AddDeceiveTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddDeceiveTokenRequestToJson(this);
}
