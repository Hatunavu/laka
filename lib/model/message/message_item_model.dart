import 'package:client_tggt/core/style/conver_time.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/shared/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_item_model.g.dart';

@JsonSerializable()
class MessageItemModel {
  @JsonKey(name: '_id')
  final String id;
  final String? content;
  final AccountModel by;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool? isSender;

  MessageItemModel(
      {required this.id,
      this.content,
      required this.by,
      this.createdAt,
      this.updatedAt,
      this.isSender});

  String? get urlUserAvatar => by.profile!.avatar!.path ?? '';

  String get fullname => by.profile!.fullName ?? '';

  String get displayTimeCreated =>
      StringUtils?.calcTimePost(createdAt ?? DateTime.now()) ?? '';

  String get displayMessageTime {
    final getDate =
        DateFormat("hh:mm dd-MM-yyyy").format(createdAt ?? DateTime.now());
    final getTime = DateFormat("hh:mm").format(createdAt ?? DateTime.now());
    final getToday = DateFormat("dd-MM-yyyy").format(DateTime.now());
    final checkDate = getDate.split(" ")[1] == getToday;
    if (checkDate == true) {
      return getTime;
    } else {
      return getDate;
    }
  }

  String get displayTime =>
      TimeAgo.timeAgoSinceDate(createdAt ?? DateTime.now());

  set setIsSender(bool status) {
    isSender = status;
  }

  factory MessageItemModel.fromJson(Map<String, dynamic> json) =>
      _$MessageItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemModelToJson(this);
}

@JsonSerializable()
class SocketMessageResponse {
  final MessageItemModel message;

  SocketMessageResponse({required this.message});

  factory SocketMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SocketMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SocketMessageResponseToJson(this);
}
