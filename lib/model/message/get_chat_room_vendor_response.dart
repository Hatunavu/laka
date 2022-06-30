import 'package:json_annotation/json_annotation.dart';

part 'get_chat_room_vendor_response.g.dart';

@JsonSerializable()
class GetChatRoomVendorResponse {
  final String? data;
  final int status;
  final String? message;

  GetChatRoomVendorResponse({this.data, required this.status, this.message});
  factory GetChatRoomVendorResponse.fromJson(Map<String, dynamic> json) =>
      _$GetChatRoomVendorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetChatRoomVendorResponseToJson(this);
}
