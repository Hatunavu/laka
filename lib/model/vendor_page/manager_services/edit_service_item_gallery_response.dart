import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_service_item_gallery_response.g.dart';

@JsonSerializable()
class UpdateServiceItemGalleryResponse {
  @JsonKey(name: 'data')
  final List<ImageModel>? data;
  final int status;
  final String message;

  UpdateServiceItemGalleryResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory UpdateServiceItemGalleryResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateServiceItemGalleryResponseFromJson(json);
}
