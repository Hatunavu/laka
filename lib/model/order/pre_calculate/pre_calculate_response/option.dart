import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  String? name;
  String? description;
  String? image;
  int? priority;
  String? type;
  int? cost;
  @JsonKey(name: '_id')
  String? id;

  Option({
    this.name,
    this.description,
    this.image,
    this.priority,
    this.type,
    this.cost,
    this.id,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return _$OptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
