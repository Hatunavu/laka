import 'package:json_annotation/json_annotation.dart';

part 'delete_post_by_id.g.dart';

@JsonSerializable()
class DeletePostByIdResponse {
  final int status;
  final String? message;

  DeletePostByIdResponse({required this.status, this.message});
  factory DeletePostByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$DeletePostByIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePostByIdResponseToJson(this);
}
