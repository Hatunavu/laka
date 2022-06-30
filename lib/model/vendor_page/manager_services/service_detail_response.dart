import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_detail_response.g.dart';

@JsonSerializable()
class ServiceDetailResponse {
  @JsonKey(name: 'data')
  final ServicesModel? data;
  final int? status;
  final String? message;
  final dynamic errors;

  ServiceDetailResponse({this.data, this.status, this.message, this.errors});

  factory ServiceDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDetailResponseToJson(this);
}
