import 'package:json_annotation/json_annotation.dart';

part 'update_vendors_thumbnail_request.g.dart';

@JsonSerializable()
class UpdateVendorsThumnailRequest {
  final String image;

  UpdateVendorsThumnailRequest({required this.image});
  factory UpdateVendorsThumnailRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateVendorsThumnailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateVendorsThumnailRequestToJson(this);
}
