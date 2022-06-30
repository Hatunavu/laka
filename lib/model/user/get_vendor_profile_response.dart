import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_vendor_profile_response.g.dart';

@JsonSerializable()
class GetVendorProfileResponse {
  @JsonKey(name: 'data')
  final GetProfileData? data;
  final int status;
  final String message;

  GetVendorProfileResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory GetVendorProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVendorProfileResponseFromJson(json);
}

@JsonSerializable()
class GetProfileData {
  final VendorInfoModel? account;
  final int? countPendingOrders;
  final int? countUnreadNotifications;

  GetProfileData({
    this.account,
    this.countPendingOrders,
    this.countUnreadNotifications,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) =>
      _$GetProfileDataFromJson(json);
}
