import 'package:client_tggt/model/rewards/reward_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_rewards_history_response.g.dart';

@JsonSerializable()
class GetListRewardsHistoryResponse {
  @JsonKey(name: 'data')
  final ListRewardsHistory data;
  final int status;
  final String? message;
  final dynamic errors;

  GetListRewardsHistoryResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory GetListRewardsHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListRewardsHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListRewardsHistoryResponseToJson(this);
}

@JsonSerializable()
class ListRewardsHistory {
  @JsonKey(name: 'docs')
  final List<RewardsModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListRewardsHistory(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListRewardsHistory.fromJson(Map<String, dynamic> json) =>
      _$ListRewardsHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ListRewardsHistoryToJson(this);
}
