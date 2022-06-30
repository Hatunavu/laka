import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_service_item_thumbnail_response.g.dart';

@JsonSerializable()
class UpdateServiceItemThumbnailResponse {
  @JsonKey(name: 'data')
  final ImageModel? data;
  final int status;
  final String message;

  UpdateServiceItemThumbnailResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory UpdateServiceItemThumbnailResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateServiceItemThumbnailResponseFromJson(json);
}
