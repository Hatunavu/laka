import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward_screen_response.g.dart';

@JsonSerializable()
class RewardScreenResponse {
  @JsonKey(name: 'data')
  final RewardScreenData? data;
  final int status;
  final String message;

  RewardScreenResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory RewardScreenResponse.fromJson(Map<String, dynamic> json) =>
      _$RewardScreenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RewardScreenResponseToJson(this);
}

@JsonSerializable()
class RewardScreenData {
  final List<BannerModel>? banners;
  final List<VoucherModel>? systemVouchers;
  final List<VoucherModel>? vendorVouchers;

  RewardScreenData({this.banners, this.systemVouchers, this.vendorVouchers});

  factory RewardScreenData.fromJson(Map<String, dynamic> json) =>
      _$RewardScreenDataFromJson(json);

  Map<String, dynamic> toJson() => _$RewardScreenDataToJson(this);
}
