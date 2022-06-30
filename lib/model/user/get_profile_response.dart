import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_profile_response.g.dart';

@JsonSerializable()
class GetProfileResponse {
  @JsonKey(name: 'data')
  final GetProfileData? data;
  final int status;
  final String message;

  GetProfileResponse({this.data, required this.status, required this.message});

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProfileResponseFromJson(json);
}

@JsonSerializable()
class GetProfileData {
  final AccountModel? account;
  final int? countPendingOrders;
  final int? countUnreadNotifications;
  final BookingItemModel? currentOrder;

  GetProfileData({
    this.account,
    this.countPendingOrders,
    this.countUnreadNotifications,
    this.currentOrder,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) =>
      _$GetProfileDataFromJson(json);
}
