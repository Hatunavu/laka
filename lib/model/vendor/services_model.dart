import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'services_model.g.dart';

@JsonSerializable()
class ServicesModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(ignore: true)
  final VendorModel? vendor;
  final String? details;
  final double? price;
  final String? note;
  final List<AttributeModel>? attributes;
  final bool? active;
  final String? status;
  final ImageModel? thumbnail;
  final List<ImageModel>? gallery;
  final int? quantity;

  ServicesModel({
    this.id,
    this.name,
    this.details,
    this.price,
    this.vendor,
    this.note,
    this.attributes,
    this.active,
    this.status,
    this.thumbnail,
    this.gallery,
    this.quantity,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesModelToJson(this);
}

@JsonSerializable()
class ImageModel {
  final String? path;
  final String? type;

  ImageModel({
    this.path,
    this.type,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
