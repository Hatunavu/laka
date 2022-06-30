import 'package:json_annotation/json_annotation.dart';

import 'locations.dart';

part 'dist.g.dart';

@JsonSerializable()
class Dist {
  double? calculated;
  Locations? locations;

  Dist({this.calculated, this.locations});

  factory Dist.fromJson(Map<String, dynamic> json) => _$DistFromJson(json);

  Map<String, dynamic> toJson() => _$DistToJson(this);
}
