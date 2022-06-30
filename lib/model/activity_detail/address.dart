import 'package:json_annotation/json_annotation.dart';

import 'location.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Location? location;
  String? fullAddress;

  Address({this.location, this.fullAddress});

  factory Address.fromJson(Map<String, dynamic> json) {
    return _$AddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
