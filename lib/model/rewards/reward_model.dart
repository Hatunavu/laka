import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward_model.g.dart';

@JsonSerializable()
class RewardsModel {
  @JsonKey(name: '_id')
  final String? id;
  final BookingItemModel order;
  final String? account;
  final double amount;
  final String type;
  RewardsModel(
      {this.id,
      required this.order,
      this.account,
      required this.amount,
      required this.type});

  factory RewardsModel.fromJson(Map<String, dynamic> json) =>
      _$RewardsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RewardsModelToJson(this);
}
