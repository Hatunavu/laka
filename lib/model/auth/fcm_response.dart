import 'package:json_annotation/json_annotation.dart';

part 'fcm_response.g.dart';

@JsonSerializable()
class FcmResponse {
  final FcmResponseData data;

  FcmResponse({
    required this.data,
  });

  factory FcmResponse.fromJson(Map<String, dynamic> json) =>
      _$FcmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FcmResponseToJson(this);
}

@JsonSerializable()
class FcmResponseData {
  final String postId;
  final String type;

  FcmResponseData({
    required this.postId,
    required this.type,
  });

  String get getPayload => '$postId+$type';

  factory FcmResponseData.fromJson(Map<String, dynamic> json) =>
      _$FcmResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$FcmResponseDataToJson(this);
}
