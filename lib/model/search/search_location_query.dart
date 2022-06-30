import 'package:json_annotation/json_annotation.dart';

part 'search_location_query.g.dart';

@JsonSerializable()
class SearchLocationQuery {
  final String? latt;
  final String? lng;
  final String? textSearch;

  SearchLocationQuery({this.latt, this.lng, this.textSearch});
  factory SearchLocationQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationQueryFromJson(json);
  Map<String, dynamic> toJson() => _$SearchLocationQueryToJson(this);
}
