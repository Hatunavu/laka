import 'package:json_annotation/json_annotation.dart';

part 'get_app_version_response.g.dart';

@JsonSerializable()
class GetAppVersionResponse {
  @JsonKey(name: 'data')
  final AppVersionData? data;
  final int status;
  final String message;

  GetAppVersionResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory GetAppVersionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAppVersionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppVersionResponseToJson(this);
}

@JsonSerializable()
class AppVersionData {
  final String iosVersion;
  final String androidVersion;

  AppVersionData({required this.iosVersion, required this.androidVersion});

  factory AppVersionData.fromJson(Map<String, dynamic> json) =>
      _$AppVersionDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionDataToJson(this);
}
