import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_notification_response.g.dart';

@JsonSerializable()
class GetListNotificationResponse {
  @JsonKey(name: 'data')
  final ListNotification data;
  final int status;
  final String? message;
  final dynamic errors;

  GetListNotificationResponse(
      {required this.data, required this.status, this.message, this.errors});
  factory GetListNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetListNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetListNotificationResponseToJson(this);
}

@JsonSerializable()
class ListNotification {
  @JsonKey(name: 'docs')
  final List<NotificationModal>? docs;
  final int? totalDocs;
  final int? limit;
  final int? totalPage;
  final int? page;
  final int? pagingCounter;

  ListNotification(
      {this.docs,
      this.totalDocs,
      this.limit,
      this.totalPage,
      this.page,
      this.pagingCounter});

  factory ListNotification.fromJson(Map<String, dynamic> json) =>
      _$ListNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ListNotificationToJson(this);
}
