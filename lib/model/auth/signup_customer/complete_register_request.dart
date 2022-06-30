import 'package:json_annotation/json_annotation.dart';

part 'complete_register_request.g.dart';

@JsonSerializable()
class CompleteRegisterRequest {
  final String fullName;

  CompleteRegisterRequest({
    required this.fullName,
  });
  factory CompleteRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteRegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CompleteRegisterRequestToJson(this);
}
