// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : CommentMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'parents': instance.parents,
      'metadata': instance.metadata,
    };

CommentParent _$CommentParentFromJson(Map<String, dynamic> json) =>
    CommentParent(
      parents: (json['parents'] as List<dynamic>)
          .map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentParentToJson(CommentParent instance) =>
    <String, dynamic>{
      'parents': instance.parents,
    };

CommentItem _$CommentItemFromJson(Map<String, dynamic> json) => CommentItem(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      parentComment: json['parentComment'] as String?,
      by: AccountModel.fromJson(json['by'] as Map<String, dynamic>),
      replies: json['replies'] == null
          ? null
          : ReplyModel.fromJson(json['replies'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CommentItemToJson(CommentItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('content', instance.content);
  writeNotNull('media', instance.media);
  val['parentComment'] = instance.parentComment;
  val['by'] = instance.by;
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  val['replies'] = instance.replies;
  return val;
}

ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => ReplyModel(
      docs: (json['docs'] as List<dynamic>)
          .map((e) => CommentItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : ReplyMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReplyModelToJson(ReplyModel instance) =>
    <String, dynamic>{
      'docs': instance.docs,
      'metadata': instance.metadata,
    };

ReplyMetadata _$ReplyMetadataFromJson(Map<String, dynamic> json) =>
    ReplyMetadata(
      totalDocs: json['totalDocs'] as int,
    );

Map<String, dynamic> _$ReplyMetadataToJson(ReplyMetadata instance) =>
    <String, dynamic>{
      'totalDocs': instance.totalDocs,
    };

ReplyItem _$ReplyItemFromJson(Map<String, dynamic> json) => ReplyItem(
      id: json['_id'] as String?,
      content: json['content'] as String?,
      media: (json['media'] as List<dynamic>?)
          ?.map((e) => GalleryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      by: AccountModel.fromJson(json['by'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ReplyItemToJson(ReplyItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  writeNotNull('content', instance.content);
  writeNotNull('media', instance.media);
  val['by'] = instance.by;
  writeNotNull('createdAt', instance.createdAt?.toIso8601String());
  writeNotNull('updatedAt', instance.updatedAt?.toIso8601String());
  return val;
}

CommentMetadata _$CommentMetadataFromJson(Map<String, dynamic> json) =>
    CommentMetadata(
      id: json['_id'] as String?,
      totalDocs: json['totalDocs'] as int?,
    );

Map<String, dynamic> _$CommentMetadataToJson(CommentMetadata instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('_id', instance.id);
  val['totalDocs'] = instance.totalDocs;
  return val;
}
