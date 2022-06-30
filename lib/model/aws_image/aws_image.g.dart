// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aws_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AwsImage _$AwsImageFromJson(Map<String, dynamic> json) => AwsImage(
      uploadUrl: json['uploadUrl'] as String?,
      downloadUrl: json['downloadUrl'] as String,
    );

Map<String, dynamic> _$AwsImageToJson(AwsImage instance) => <String, dynamic>{
      'uploadUrl': instance.uploadUrl,
      'downloadUrl': instance.downloadUrl,
    };

GenerateAwsImageResponse _$GenerateAwsImageResponseFromJson(
        Map<String, dynamic> json) =>
    GenerateAwsImageResponse(
      awsImage: AwsImage.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$GenerateAwsImageResponseToJson(
        GenerateAwsImageResponse instance) =>
    <String, dynamic>{
      'data': instance.awsImage,
      'status': instance.status,
      'message': instance.message,
    };

GenerateAwsImageRequest _$GenerateAwsImageRequestFromJson(
        Map<String, dynamic> json) =>
    GenerateAwsImageRequest(
      fileType: json['fileType'] as String,
    );

Map<String, dynamic> _$GenerateAwsImageRequestToJson(
        GenerateAwsImageRequest instance) =>
    <String, dynamic>{
      'fileType': instance.fileType,
    };
