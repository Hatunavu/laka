import 'package:json_annotation/json_annotation.dart';

part 'edit_service_item_thumbnail_request.g.dart';

@JsonSerializable()
class UpdateServiceItemThumbnailRequest {
  final String image;

  UpdateServiceItemThumbnailRequest({required this.image});
  factory UpdateServiceItemThumbnailRequest.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateServiceItemThumbnailRequestFromJson(json);
  Map<String, dynamic> toJson() =>
      _$UpdateServiceItemThumbnailRequestToJson(this);
}
