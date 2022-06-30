import 'package:json_annotation/json_annotation.dart';

part 'add_message_item_request.g.dart';

@JsonSerializable()
class AddMessageItemRequest {
  final String? content;

  AddMessageItemRequest({this.content});

  factory AddMessageItemRequest.fromJson(Map<String, dynamic> json) {
    return _$AddMessageItemRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddMessageItemRequestToJson(this);
}
