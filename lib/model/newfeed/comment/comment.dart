import 'package:client_tggt/core/style/conver_time.dart';
import 'package:client_tggt/model/review/list_review_response/gallery.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/shared/utils/string_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final List<CommentItem>? parents;
  final CommentMetadata? metadata;
  Comment({this.parents, this.metadata});

  int? get commentTotal => metadata!.totalDocs ?? 0;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CommentParent {
  final List<CommentItem> parents;

  CommentParent({required this.parents});

  factory CommentParent.fromJson(Map<String, dynamic> json) =>
      _$CommentParentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentParentToJson(this);
}

@JsonSerializable()
class CommentItem {
  @JsonKey(name: '_id', includeIfNull: false)
  String? id;
  @JsonKey(name: 'content', includeIfNull: false)
  String? content;

  @JsonKey(name: 'media', includeIfNull: false)
  final List<GalleryModel>? media;
  final String? parentComment;
  @JsonKey(name: 'by', includeIfNull: false)
  final AccountModel by;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;

  ReplyModel? replies;

  CommentItem(
      {this.id,
      this.content,
      this.media,
      this.parentComment,
      required this.by,
      this.replies,
      this.createdAt,
      this.updatedAt});

  String get displayName => by.profile!.fullName ?? '';

  String? get urlUserAvatar => by.profile!.avatar!.path ?? "";

  String get displayTimePostCreated =>
      StringUtils?.calcTimePost(createdAt ?? DateTime.now()) ?? '';

  String get displayTimeComment =>
      TimeAgo.timeAgoSinceDate(createdAt ?? DateTime.now());

  set repliesObject(ReplyModel value) {
    replies = value;
  }

  factory CommentItem.fromJson(Map<String, dynamic> json) =>
      _$CommentItemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentItemToJson(this);
}

@JsonSerializable()
class ReplyModel {
  List<CommentItem> docs;
  final ReplyMetadata? metadata;
  ReplyModel({required this.docs, this.metadata});

  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyModelToJson(this);
}

@JsonSerializable()
class ReplyMetadata {
  final int totalDocs;

  ReplyMetadata({required this.totalDocs});

  factory ReplyMetadata.fromJson(Map<String, dynamic> json) =>
      _$ReplyMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyMetadataToJson(this);
}

@JsonSerializable()
class ReplyItem {
  @JsonKey(name: '_id', includeIfNull: false)
  String? id;
  @JsonKey(name: 'content', includeIfNull: false)
  String? content;

  @JsonKey(name: 'media', includeIfNull: false)
  final List<GalleryModel>? media;
  @JsonKey(name: 'by', includeIfNull: false)
  final AccountModel by;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;

  ReplyItem(
      {this.id,
      this.content,
      this.media,
      required this.by,
      this.createdAt,
      this.updatedAt});

  String get displayName => by.profile!.fullName ?? '';

  String? get urlUserAvatar => by.profile!.avatar!.path ?? "";

  String get displayTimePostCreated =>
      StringUtils?.calcTimePost(createdAt ?? DateTime.now()) ?? '';

  String get displayTimeComment =>
      TimeAgo.timeAgoSinceDate(createdAt ?? DateTime.now());

  factory ReplyItem.fromJson(Map<String, dynamic> json) =>
      _$ReplyItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyItemToJson(this);
}

@JsonSerializable()
class CommentMetadata {
  @JsonKey(name: '_id', includeIfNull: false)
  String? id;

  final int? totalDocs;

  CommentMetadata({this.id, this.totalDocs});

  factory CommentMetadata.fromJson(Map<String, dynamic> json) =>
      _$CommentMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$CommentMetadataToJson(this);
}
