import 'package:json_annotation/json_annotation.dart';
import 'package:client_tggt/model/message/message_item_model.dart';
part 'add_message_item_response.g.dart';

@JsonSerializable()
class AddMessageItemResponse {
  @JsonKey(name: 'data')
  final MessageItemModel data;
  final int status;
  final String? message;

  AddMessageItemResponse(
      {required this.data, required this.status, this.message});
  factory AddMessageItemResponse.fromJson(Map<String, dynamic> json) =>
      _$AddMessageItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddMessageItemResponseToJson(this);
}
