import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Locations {
  String? type;
  List<double>? coordinates;

  Locations({this.type, this.coordinates});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return _$LocationsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}
