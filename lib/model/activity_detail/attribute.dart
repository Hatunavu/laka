import 'package:json_annotation/json_annotation.dart';

part 'attribute.g.dart';

@JsonSerializable()
class Attribute {
  String? name;
  String? description;
  String? image;
  int? priority;
  String? type;
  int? cost;
  @JsonKey(name: '_id')
  String? id;

  Attribute({
    this.name,
    this.description,
    this.image,
    this.priority,
    this.type,
    this.cost,
    this.id,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return _$AttributeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttributeToJson(this);
}
