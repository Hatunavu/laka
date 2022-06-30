import 'package:json_annotation/json_annotation.dart';

part 'tagline_model.g.dart';

@JsonSerializable()
class TaglineModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String? description;
  final int? priority;
  final String type;

  TaglineModel(
      {required this.id,
      required this.name,
      this.description,
      this.priority,
      required this.type});

  factory TaglineModel.fromJson(Map<String, dynamic> json) =>
      _$TaglineModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaglineModelToJson(this);
}
