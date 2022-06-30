// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationQuery _$SearchLocationQueryFromJson(Map<String, dynamic> json) =>
    SearchLocationQuery(
      latt: json['latt'] as String?,
      lng: json['lng'] as String?,
      textSearch: json['textSearch'] as String?,
    );

Map<String, dynamic> _$SearchLocationQueryToJson(
        SearchLocationQuery instance) =>
    <String, dynamic>{
      'latt': instance.latt,
      'lng': instance.lng,
      'textSearch': instance.textSearch,
    };
