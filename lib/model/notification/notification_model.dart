import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/notification/notification_enum.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModal {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'account', includeIfNull: false)
  final String account;

  @JsonKey(name: 'isRead', defaultValue: false)
  bool isRead;

  @JsonKey(name: 'active', includeIfNull: false)
  final bool? active;
  @JsonKey(
    name: 'type',
    fromJson: stringToNotificationType,
    toJson: notificationTypeToString,
  )
  final NotificationType type;
  final DateTime createdAt;
  final String onModel;
  // final NotificationRef ref;
  final PostRef? post;
  final NotificationRef? order;
  final String ref;
  final String? content;

  NotificationModal(
      {required this.id,
      required this.account,
      required this.isRead,
      required this.type,
      this.active,
      required this.createdAt,
      required this.onModel,
      required this.ref,
      this.post,
      this.content,
      this.order});
  String get displayNotifBy {
    if (post == null) {
      return order!.vendor!.brandName;
    } else {
      return post!.by.profile!.fullName ?? "";
    }
  }

  String get customerUsername => order?.customer?.profile?.fullName ?? "";

  String get customerAvatar => order?.customer?.profile!.avatar!.path ?? "";

  String get displayAvatar {
    if (post == null) {
      return order!.vendor!.thumbnail.path ?? "";
    }
    return post!.by.profile!.avatar!.path ?? "";
  }

  factory NotificationModal.fromJson(Map<String, dynamic> json) =>
      _$NotificationModalFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModalToJson(this);
}

@JsonSerializable()
class PostRef {
  @JsonKey(name: '_id')
  final String id;
  final AccountModel by;

  PostRef({required this.id, required this.by});
  factory PostRef.fromJson(Map<String, dynamic> json) =>
      _$PostRefFromJson(json);

  Map<String, dynamic> toJson() => _$PostRefToJson(this);
}

@JsonSerializable()
class NotificationRef {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'vendor', includeIfNull: false)
  final NotificationVendor? vendor;
  final AccountModel? customer;

  NotificationRef({required this.id, this.vendor, this.customer});
  factory NotificationRef.fromJson(Map<String, dynamic> json) =>
      _$NotificationRefFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRefToJson(this);
}

@JsonSerializable()
class NotificationVendor {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(
      name: 'category',
      fromJson: stringToCategoryType,
      toJson: categoryTypeToString,
      includeIfNull: false)
  final CategoryType category;

  @JsonKey(name: 'brandName', includeIfNull: false, defaultValue: "")
  final String brandName;
  final ImageModel thumbnail;
  @JsonKey(name: 'categoryImage', includeIfNull: false, defaultValue: "")
  final String? categoryImage;

  NotificationVendor(
      {required this.id,
      required this.category,
      required this.brandName,
      required this.thumbnail,
      required this.categoryImage});
  factory NotificationVendor.fromJson(Map<String, dynamic> json) =>
      _$NotificationVendorFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationVendorToJson(this);
}
