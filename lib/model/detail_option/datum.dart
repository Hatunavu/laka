import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class Datum {
  String? name;
  String? description;
  String? image;
  int? priority;
  String? type;
  int? cost;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(defaultValue: false)
  bool? isSelect;
  @JsonKey(defaultValue: 0)
  int? quantity;

  Datum({
    this.name,
    this.description,
    this.image,
    this.priority,
    this.type,
    this.cost,
    this.id,
    this.isSelect,
    this.quantity,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
