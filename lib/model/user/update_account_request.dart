import 'package:json_annotation/json_annotation.dart';

part 'update_account_request.g.dart';

@JsonSerializable()
class UpdateAccountRequest {
  final String avatar;

  UpdateAccountRequest({required this.avatar});
  factory UpdateAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAccountRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateAccountRequestToJson(this);
}
