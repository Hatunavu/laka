import 'package:json_annotation/json_annotation.dart';

part 'aws_image.g.dart';

@JsonSerializable()
class AwsImage {
  final String? uploadUrl;
  final String downloadUrl;

  AwsImage({
    this.uploadUrl,
    required this.downloadUrl,
  });

  factory AwsImage.fromJson(Map<String, dynamic> json) =>
      _$AwsImageFromJson(json);

  Map<String, dynamic> toJson() => _$AwsImageToJson(this);
}

@JsonSerializable()
class GenerateAwsImageResponse {
  @JsonKey(name: 'data')
  final AwsImage awsImage;
  final int status;
  final String message;

  GenerateAwsImageResponse({
    required this.awsImage,
    required this.status,
    required this.message,
  });

  factory GenerateAwsImageResponse.fromJson(Map<String, dynamic> json) =>
      _$GenerateAwsImageResponseFromJson(json);
}

@JsonSerializable()
class GenerateAwsImageRequest {
  final String fileType;

  GenerateAwsImageRequest({required this.fileType});

  Map<String, dynamic> toJson() => _$GenerateAwsImageRequestToJson(this);
}
