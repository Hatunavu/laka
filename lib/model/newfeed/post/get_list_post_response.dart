import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_list_post_response.g.dart';

@JsonSerializable()
class GetListPostResponse {
  @JsonKey(name: 'data')
  final ListPost data;
  final int status;
  final String? message;

  GetListPostResponse({required this.data, required this.status, this.message});
  factory GetListPostResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListPostResponseToJson(this);
}

@JsonSerializable()
class ListPost {
  @JsonKey(name: 'docs')
  final List<PostModel>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListPost(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListPost.fromJson(Map<String, dynamic> json) =>
      _$ListPostFromJson(json);

  Map<String, dynamic> toJson() => _$ListPostToJson(this);
}
