import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String image;
  final String type;
  final VendorModel? vendor;
  BannerModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.type,
      this.vendor});

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
