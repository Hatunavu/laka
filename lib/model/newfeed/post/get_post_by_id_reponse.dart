import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_post_by_id_reponse.g.dart';

@JsonSerializable()
class GetPostByIdResponse {
  @JsonKey(name: 'data')
  final PostModel data;
  final int status;
  final String? message;

  GetPostByIdResponse({required this.data, required this.status, this.message});
  factory GetPostByIdResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostByIdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostByIdResponseToJson(this);
}
