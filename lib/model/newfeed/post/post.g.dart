// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      id: json['_id'] as String,
      content: json['content'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      by: AccountModel.fromJson(json['by'] as Map<String, dynamic>),
      active: json['active'] as bool,
      totalReactions: json['totalReactions'] == null
          ? null
          : ReactionModel.fromJson(
              json['totalReactions'] as Map<String, dynamic>),
      reacted: json['reacted'] == null
          ? null
          : ReactedModel.fromJson(json['reacted'] as Map<String, dynamic>),
      totalComments: json['totalComments'] as int,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      comments: json['comments'] == null
          ? null
          : Comment.fromJson(json['comments'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => TagsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'content': instance.content,
    'media': instance.media,
    'by': instance.by,
    'active': instance.active,
    'totalReactions': instance.totalReactions,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reacted', instance.reacted);
  val['createdAt'] = instance.createdAt?.toIso8601String();
  val['updatedAt'] = instance.updatedAt?.toIso8601String();
  val['totalComments'] = instance.totalComments;
  val['comments'] = instance.comments;
  val['tags'] = instance.tags;
  return val;
}

ReactionModel _$ReactionModelFromJson(Map<String, dynamic> json) =>
    ReactionModel(
      love: (json['love'] as num).toDouble(),
    );

Map<String, dynamic> _$ReactionModelToJson(ReactionModel instance) =>
    <String, dynamic>{
      'love': instance.love,
    };

ReactedModel _$ReactedModelFromJson(Map<String, dynamic> json) => ReactedModel(
      id: json['_id'] as String,
      type: stringToReactionType(json['type'] as String),
    );

Map<String, dynamic> _$ReactedModelToJson(ReactedModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': reactionTypeToString(instance.type),
    };

TagsModel _$TagsModelFromJson(Map<String, dynamic> json) => TagsModel(
      id: json['_id'] as String,
      type: json['type'] as String,
      vendor: VendorModel.fromJson(json['vendor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagsModelToJson(TagsModel instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'vendor': instance.vendor,
    };
