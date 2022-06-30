import 'package:json_annotation/json_annotation.dart';

part 'create_new_post_request.g.dart';

@JsonSerializable()
class CreateNewPostRequest {
  final String content;
  final List<String>? media;
  final List<TagsRequest> tags;
  final List<UploadMediaModel>? uploadMedia;
  CreateNewPostRequest(
      {required this.content,
      this.media,
      required this.tags,
      this.uploadMedia});

  factory CreateNewPostRequest.fromJson(Map<String, dynamic> json) {
    return _$CreateNewPostRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CreateNewPostRequestToJson(this);
}

@JsonSerializable()
class UploadMediaModel {
  final int? width;
  final int? height;
  final String url;

  UploadMediaModel({this.width, this.height, required this.url});

  factory UploadMediaModel.fromJson(Map<String, dynamic> json) {
    return _$UploadMediaModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UploadMediaModelToJson(this);
}

@JsonSerializable()
class TagsRequest {
  final String type;
  final String vendor;

  TagsRequest({required this.type, required this.vendor});

  factory TagsRequest.fromJson(Map<String, dynamic> json) {
    return _$TagsRequestFromJson(json);
  }
  Map<String, dynamic> toJson() => _$TagsRequestToJson(this);
}
