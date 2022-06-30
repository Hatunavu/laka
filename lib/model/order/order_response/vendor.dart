import 'package:json_annotation/json_annotation.dart';

part 'vendor.g.dart';

@JsonSerializable()
class Vendor {
  Vendor? vendor;

  Vendor({this.vendor});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return _$VendorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
