import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reward_data.g.dart';

@JsonSerializable()
class RewardData {
  @JsonKey(
    name: 'currentTier',
    fromJson: intToTierType,
    toJson: tierTypeToInt,
  )
  TierType currentTier;
  @JsonKey(
    name: 'nextTier',
    fromJson: intToTierType,
    toJson: tierTypeToInt,
  )
  TierType nextTier;
  int? pointsToLevelUp;
  double? progressPercentage;
  int? currentPoints;
  int? prevTierPoints;
  int? nextTierPoints;

  RewardData({
    required this.currentTier,
    required this.nextTier,
    this.currentPoints,
    this.prevTierPoints,
    this.nextTierPoints,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) =>
      _$RewardDataFromJson(json);

  Map<String, dynamic> toJson() => _$RewardDataToJson(this);
}

enum TierType { none, silver, gold, diamond, blackDiamond }

extension EnumTier on TierType {
  int value() {
    return tierTypeToInt(this);
  }

  TierType parse(int value) {
    return intToTierType(value);
  }

  int getType() {
    switch (this) {
      case TierType.none:
        return 0;
      case TierType.silver:
        return 1;
      case TierType.gold:
        return 2;
      case TierType.diamond:
        return 3;
      case TierType.blackDiamond:
        return 4;
    }
  }

  String display() {
    switch (this) {
      case TierType.none:
        return 'noneTier'.tr;
      case TierType.silver:
        return 'silverTier'.tr;
      case TierType.gold:
        return 'goldTier'.tr;
      case TierType.diamond:
        return 'diamondTier'.tr;
      case TierType.blackDiamond:
        return 'blackDiamondTier'.tr;
    }
  }
}

TierType intToTierType(int type) {
  switch (type) {
    case 0:
      return TierType.none;
    case 1:
      return TierType.silver;
    case 2:
      return TierType.gold;
    case 3:
      return TierType.diamond;
    case 4:
      return TierType.blackDiamond;
    default:
      return TierType.none;
  }
}

int tierTypeToInt(TierType type) {
  switch (type) {
    case TierType.none:
      return 0;
    case TierType.silver:
      return 1;
    case TierType.gold:
      return 2;
    case TierType.diamond:
      return 3;
    case TierType.blackDiamond:
      return 4;
  }
}
