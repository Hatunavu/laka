import 'package:client_tggt/model/user/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_account_response.g.dart';

@JsonSerializable()
class UpdateAccountResponse {
  @JsonKey(name: 'data')
  final AvatarAccount? data;
  final int status;
  final String message;

  UpdateAccountResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory UpdateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAccountResponseFromJson(json);
}
