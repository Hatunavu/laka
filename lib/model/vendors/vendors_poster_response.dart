import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/category/home_splash_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendors_poster_response.g.dart';

@JsonSerializable()
class VendorsPosterResponse {
  final VendorsPosterResponseData data;
  final int status;
  final String message;

  VendorsPosterResponse(
      {required this.data, required this.status, required this.message});

  factory VendorsPosterResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorsPosterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsPosterResponseToJson(this);
}

@JsonSerializable()
class VendorsPosterResponseData {
  final List<BannerModel>? banners;
  final List<VendorModel>? recommendVendors;
  VendorsPosterResponseData({this.banners, this.recommendVendors});

  factory VendorsPosterResponseData.fromJson(Map<String, dynamic> json) =>
      _$VendorsPosterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$VendorsPosterResponseDataToJson(this);
}
