import 'package:client_tggt/model/user/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_affiliate_response.g.dart';

@JsonSerializable()
class GetListAffiliateResponse {
  @JsonKey(name: 'data')
  final ListAffiliateData data;
  final int status;
  final String? message;

  GetListAffiliateResponse(
      {required this.data, required this.status, this.message});
  factory GetListAffiliateResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListAffiliateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListAffiliateResponseToJson(this);
}

@JsonSerializable()
class ListAffiliateData {
  final List<AccountModel> firstLevels;
  final List<AccountModel> secondLevels;
  final int totalFirsts;
  final int totalSeconds;

  ListAffiliateData(
      {required this.firstLevels,
      required this.secondLevels,
      required this.totalFirsts,
      required this.totalSeconds});
  factory ListAffiliateData.fromJson(Map<String, dynamic> json) =>
      _$ListAffiliateDataFromJson(json);

  Map<String, dynamic> toJson() => _$ListAffiliateDataToJson(this);
}
