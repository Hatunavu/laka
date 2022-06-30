import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_attribute_response.g.dart';

@JsonSerializable()
class GetListAttributeResponse {
  @JsonKey(name: 'data')
  final List<AttributeModel>? data;
  final int status;
  final String message;

  GetListAttributeResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory GetListAttributeResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListAttributeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListAttributeResponseToJson(this);
}
