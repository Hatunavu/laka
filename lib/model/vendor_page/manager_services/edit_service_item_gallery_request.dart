import 'package:json_annotation/json_annotation.dart';

part 'edit_service_item_gallery_request.g.dart';

@JsonSerializable()
class UpdateServiceItemGalleryRequest {
  final List<String> images;

  UpdateServiceItemGalleryRequest({required this.images});
  factory UpdateServiceItemGalleryRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateServiceItemGalleryRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UpdateServiceItemGalleryRequestToJson(this);
}
