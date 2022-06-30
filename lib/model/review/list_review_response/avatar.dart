import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable()
class Avatar {
  String? path;
  String? type;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;

  Avatar({this.path, this.type, this.id, this.createdAt, this.updatedAt});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return _$AvatarFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
