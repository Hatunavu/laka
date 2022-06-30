import 'package:json_annotation/json_annotation.dart';

import 'district_data.dart';

part 'district_response.g.dart';

@JsonSerializable()
class DistrictResponse {
  List<DistrictData>? data;
  int? status;
  String? message;
  dynamic errors;

  DistrictResponse({this.data, this.status, this.message, this.errors});

  factory DistrictResponse.fromJson(Map<String, dynamic> json) {
    return _$DistrictResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DistrictResponseToJson(this);
}
