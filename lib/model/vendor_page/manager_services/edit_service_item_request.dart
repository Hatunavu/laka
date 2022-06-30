import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_service_item_request.g.dart';

@JsonSerializable()
class EditServiceItemRequest {
  final String? name;
  final String? details;
  final String? note;
  final int? price;
  final List<AttributeModel>? attributes;
  final bool? active;
  final String? status;

  EditServiceItemRequest(
      {this.name,
      this.details,
      this.note,
      this.price,
      this.attributes,
      this.active,
      this.status});

  factory EditServiceItemRequest.fromJson(Map<String, dynamic> json) =>
      _$EditServiceItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EditServiceItemRequestToJson(this);
}
