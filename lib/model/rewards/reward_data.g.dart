// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RewardData _$RewardDataFromJson(Map<String, dynamic> json) => RewardData(
      currentTier: intToTierType(json['currentTier'] as int),
      nextTier: intToTierType(json['nextTier'] as int),
      currentPoints: json['currentPoints'] as int?,
      prevTierPoints: json['prevTierPoints'] as int?,
      nextTierPoints: json['nextTierPoints'] as int?,
    )
      ..pointsToLevelUp = json['pointsToLevelUp'] as int?
      ..progressPercentage = (json['progressPercentage'] as num?)?.toDouble();

Map<String, dynamic> _$RewardDataToJson(RewardData instance) =>
    <String, dynamic>{
      'currentTier': tierTypeToInt(instance.currentTier),
      'nextTier': tierTypeToInt(instance.nextTier),
      'pointsToLevelUp': instance.pointsToLevelUp,
      'progressPercentage': instance.progressPercentage,
      'currentPoints': instance.currentPoints,
      'prevTierPoints': instance.prevTierPoints,
      'nextTierPoints': instance.nextTierPoints,
    };
