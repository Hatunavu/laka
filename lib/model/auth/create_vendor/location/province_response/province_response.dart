import 'package:json_annotation/json_annotation.dart';

import 'province_data.dart';

part 'province_response.g.dart';

@JsonSerializable()
class ProvinceResponse {
  List<ProvinceData>? data;
  int? status;
  String? message;
  dynamic errors;

  ProvinceResponse({this.data, this.status, this.message, this.errors});

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) {
    return _$ProvinceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProvinceResponseToJson(this);
}
