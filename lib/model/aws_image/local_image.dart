import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';

class LocalImage {
  final String? name;
  final String? resource;
  final AwsImage awsImage;
  final String? type;
  final DimensionsModel? dimensions;

  LocalImage(
      {this.name,
      this.resource,
      required this.awsImage,
      this.type,
      this.dimensions});
}

class LocalImagePick {
  final String name;
  final String fileType;
  final String resource;
  final String? type;
  final DimensionsModel? dimensions;
  LocalImagePick(
      {required this.name,
      required this.fileType,
      required this.resource,
      this.dimensions,
      this.type});
}
