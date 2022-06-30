// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dist _$DistFromJson(Map<String, dynamic> json) => Dist(
      calculated: (json['calculated'] as num?)?.toDouble(),
      locations: json['locations'] == null
          ? null
          : Locations.fromJson(json['locations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DistToJson(Dist instance) => <String, dynamic>{
      'calculated': instance.calculated,
      'locations': instance.locations,
    };
