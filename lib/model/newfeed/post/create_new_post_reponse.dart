import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_new_post_reponse.g.dart';

@JsonSerializable()
class CreateNewPostResponse {
  @JsonKey(name: 'data')
  final PostData? data;
  final int status;
  final String message;

  CreateNewPostResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory CreateNewPostResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateNewPostResponseFromJson(json);
}

@JsonSerializable()
class PostData {
  final String? content;
  final List<ImageModel>? medias;

  PostData({this.content, this.medias});

  factory PostData.fromJson(Map<String, dynamic> json) =>
      _$PostDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostDataToJson(this);
}
