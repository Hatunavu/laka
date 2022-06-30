import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'detail_option_response.g.dart';

@JsonSerializable()
class DetailOptionResponse {
  List<Datum>? data;
  int? status;
  String? message;
  dynamic errors;

  DetailOptionResponse({this.data, this.status, this.message, this.errors});

  factory DetailOptionResponse.fromJson(Map<String, dynamic> json) {
    return _$DetailOptionResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DetailOptionResponseToJson(this);
}
