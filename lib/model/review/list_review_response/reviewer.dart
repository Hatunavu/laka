import 'package:json_annotation/json_annotation.dart';

import 'authentication.dart';
import 'profile.dart';

part 'reviewer.g.dart';

@JsonSerializable()
class Reviewer {
  @JsonKey(name: '_id')
  String? id;
  Profile? profile;
  String? phone;
  String? type;
  Authentication? authentication;
  String? createdAt;
  String? updatedAt;

  Reviewer({
    this.id,
    this.profile,
    this.phone,
    this.type,
    this.authentication,
    this.createdAt,
    this.updatedAt,
  });

  factory Reviewer.fromJson(Map<String, dynamic> json) {
    return _$ReviewerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReviewerToJson(this);
}
