import 'package:client_tggt/model/user/account_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_customer_profile.response.g.dart';

@JsonSerializable()
class GetCustomerProfileResponse {
  @JsonKey(name: 'data')
  final GetProfileData? data;
  final int status;
  final String message;

  GetCustomerProfileResponse({
    this.data,
    required this.status,
    required this.message,
  });

  factory GetCustomerProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCustomerProfileResponseFromJson(json);
}

@JsonSerializable()
class GetProfileData {
  final AccountModel? account;
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
