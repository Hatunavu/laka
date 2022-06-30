import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_services_response.g.dart';

@JsonSerializable()
class AddServiceResponse {
  @JsonKey(name: 'data')
  final ServicesModel? data;
  final int? status;
  final String? message;
  final dynamic errors;

  AddServiceResponse({this.data, this.status, this.message, this.errors});

  factory AddServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$AddServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddServiceResponseToJson(this);
}
