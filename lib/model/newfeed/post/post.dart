import 'package:client_tggt/core/style/conver_time.dart';
import 'package:client_tggt/model/newfeed/comment/comment.dart';
import 'package:client_tggt/model/newfeed/post/reaction_enum.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: '_id')
  final String id;
  final String? content;
  final List<GalleryModel>? media;
  @JsonKey(name: 'by')
  final AccountModel by;
  final bool active;
  ReactionModel? totalReactions;
  @JsonKey(name: 'reacted', includeIfNull: false)
  ReactedModel? reacted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int totalComments;
  final Comment? comments;
  final List<TagsModel>? tags;

  PostModel(
      {required this.id,
      this.content,
      this.media,
      required this.by,
      required this.active,
      this.totalReactions,
      this.reacted,
      required this.totalComments,
      this.createdAt,
      this.updatedAt,
      this.comments,
      this.tags});

  String? get urlUserAvatar => by.profile!.avatar!.path ?? '';

  int get countReactionLove => totalReactions!.love.toInt();

  String get fullname => by.profile!.fullName ?? '';

  String get displayTimePostCreated {
    final getDate =
        DateFormat("hh:mm dd/MM/yyyy").format(createdAt ?? DateTime.now());
    final getTime = DateFormat("hh:mm").format(createdAt ?? DateTime.now());
    final getToday = DateFormat("dd/MM/yyyy").format(DateTime.now());
    final checkDate = getDate.split(" ")[1] == getToday;
    if (checkDate == true) {
      return getTime;
    } else {
      return DateFormat("monthFormat".tr).format(createdAt ?? DateTime.now());
    }
  }

  String get displayTimeComment =>
      TimeAgo.timeAgoSinceDate(createdAt ?? DateTime.now());

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class ReactionModel {
  final double love;

  ReactionModel({required this.love});

  factory ReactionModel.fromJson(Map<String, dynamic> json) =>
      _$ReactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReactionModelToJson(this);
}

@JsonSerializable()
class ReactedModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(
    name: 'type',
    fromJson: stringToReactionType,
    toJson: reactionTypeToString,
  )
  final ReactionType type;

  ReactedModel({required this.id, required this.type});

  factory ReactedModel.fromJson(Map<String, dynamic> json) =>
      _$ReactedModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReactedModelToJson(this);
}

@JsonSerializable()
class TagsModel {
  @JsonKey(name: '_id')
  final String id;
  final String type;
  final VendorModel vendor;

  TagsModel({required this.id, required this.type, required this.vendor});

  factory TagsModel.fromJson(Map<String, dynamic> json) =>
      _$TagsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagsModelToJson(this);
}
