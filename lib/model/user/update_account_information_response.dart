import 'package:client_tggt/model/user/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_account_information_response.g.dart';

@JsonSerializable()
class UpdateAccountInformationResponse {
  @JsonKey(name: 'data')
  final AccountModel? account;
  final int status;
  final String message;

  UpdateAccountInformationResponse({
    this.account,
    required this.status,
    required this.message,
  });

  factory UpdateAccountInformationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateAccountInformationResponseFromJson(json);
}
