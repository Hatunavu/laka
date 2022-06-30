import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_service_item_response.g.dart';

@JsonSerializable()
class EditServiceItemResponse {
  @JsonKey(name: 'data')
  final ServicesModel? data;
  final int? status;
  final String? message;
  final dynamic errors;

  EditServiceItemResponse({this.data, this.status, this.message, this.errors});

  factory EditServiceItemResponse.fromJson(Map<String, dynamic> json) =>
      _$EditServiceItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EditServiceItemResponseToJson(this);
}
