import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_screen_response.g.dart';

@JsonSerializable()
class HomeScreenResponse {
  @JsonKey(name: 'data')
  final HotAndSuggestVendors? data;
  final int status;
  final String message;

  HomeScreenResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory HomeScreenResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeScreenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeScreenResponseToJson(this);
}

@JsonSerializable()
class HotAndSuggestVendors {
  List<VendorModel> hotVendors;
  final List<VendorModel> suggestedVendors;
  final List<BannerModel>? banners;
  @JsonKey(defaultValue: "0.1.3")
  final String? appVersion;
  HotAndSuggestVendors(
      {required this.hotVendors,
      required this.suggestedVendors,
      this.banners,
      this.appVersion});

  factory HotAndSuggestVendors.fromJson(Map<String, dynamic> json) =>
      _$HotAndSuggestVendorsFromJson(json);

  Map<String, dynamic> toJson() => _$HotAndSuggestVendorsToJson(this);
}
