// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModal _$NotificationModalFromJson(Map<String, dynamic> json) =>
    NotificationModal(
      id: json['_id'] as String,
      account: json['account'] as String,
      isRead: json['isRead'] as bool? ?? false,
      type: stringToNotificationType(json['type'] as String),
      active: json['active'] as bool?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      onModel: json['onModel'] as String,
      ref: json['ref'] as String,
      post: json['post'] == null
          ? null
          : PostRef.fromJson(json['post'] as Map<String, dynamic>),
      content: json['content'] as String?,
      order: json['order'] == null
          ? null
          : NotificationRef.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModalToJson(NotificationModal instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
    'account': instance.account,
    'isRead': instance.isRead,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('active', instance.active);
  val['type'] = notificationTypeToString(instance.type);
  val['createdAt'] = instance.createdAt.toIso8601String();
  val['onModel'] = instance.onModel;
  val['post'] = instance.post;
  val['order'] = instance.order;
  val['ref'] = instance.ref;
  val['content'] = instance.content;
  return val;
}

PostRef _$PostRefFromJson(Map<String, dynamic> json) => PostRef(
      id: json['_id'] as String,
      by: AccountModel.fromJson(json['by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostRefToJson(PostRef instance) => <String, dynamic>{
      '_id': instance.id,
      'by': instance.by,
    };

NotificationRef _$NotificationRefFromJson(Map<String, dynamic> json) =>
    NotificationRef(
      id: json['_id'] as String,
      vendor: json['vendor'] == null
          ? null
          : NotificationVendor.fromJson(json['vendor'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : AccountModel.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationRefToJson(NotificationRef instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('vendor', instance.vendor);
  val['customer'] = instance.customer;
  return val;
}

NotificationVendor _$NotificationVendorFromJson(Map<String, dynamic> json) =>
    NotificationVendor(
      id: json['_id'] as String,
      category: stringToCategoryType(json['category'] as String),
      brandName: json['brandName'] as String? ?? '',
      thumbnail: ImageModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
      categoryImage: json['categoryImage'] as String? ?? '',
    );

Map<String, dynamic> _$NotificationVendorToJson(NotificationVendor instance) {
  final val = <String, dynamic>{
    '_id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('category', categoryTypeToString(instance.category));
  val['brandName'] = instance.brandName;
  val['thumbnail'] = instance.thumbnail;
  writeNotNull('categoryImage', instance.categoryImage);
  return val;
}
