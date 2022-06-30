import 'package:json_annotation/json_annotation.dart';

import 'ward_data.dart';

part 'ward_response.g.dart';

@JsonSerializable()
class WardResponse {
  List<WardData>? data;
  int? status;
  String? message;
  dynamic errors;

  WardResponse({this.data, this.status, this.message, this.errors});

  factory WardResponse.fromJson(Map<String, dynamic> json) {
    return _$WardResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WardResponseToJson(this);
}
