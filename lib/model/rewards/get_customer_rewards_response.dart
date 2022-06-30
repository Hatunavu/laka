import 'package:json_annotation/json_annotation.dart';

import 'reward_data.dart';

part 'get_customer_rewards_response.g.dart';

@JsonSerializable()
class GetCustomerRewardsResponse {
  RewardData? data;
  int? status;
  String? message;
  dynamic errors;

  GetCustomerRewardsResponse({
    this.data,
    this.status,
    this.message,
    this.errors,
  });

  factory GetCustomerRewardsResponse.fromJson(Map<String, dynamic> json) {
    return _$GetCustomerRewardsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetCustomerRewardsResponseToJson(this);
}
