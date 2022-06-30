import 'package:json_annotation/json_annotation.dart';

import 'avatar.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  String? fullName;
  Avatar? avatar;

  Profile({this.fullName, this.avatar});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
