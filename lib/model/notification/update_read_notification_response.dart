import 'package:json_annotation/json_annotation.dart';

part 'update_read_notification_response.g.dart';

@JsonSerializable()
class UpdateReadNotificationResponse {
  final int status;
  final String message;

  UpdateReadNotificationResponse({
    required this.status,
    required this.message,
  });

  factory UpdateReadNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateReadNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateReadNotificationResponseToJson(this);
}
