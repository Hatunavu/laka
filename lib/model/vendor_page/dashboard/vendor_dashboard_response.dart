import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor_dashboard_response.g.dart';

@JsonSerializable()
class VendorDashboardResponse {
  @JsonKey(name: 'data')
  final DashboardData? data;
  final int status;
  final String? message;
  final dynamic errors;

  VendorDashboardResponse(
      {this.data, required this.status, this.message, this.errors});
  factory VendorDashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorDashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorDashboardResponseToJson(this);
}

@JsonSerializable()
class DashboardData {
  final List<RevenueItem>? chart;
  final RevenueData? revenue;
  final int? completedOrders;
  final int? canceledOrders;
  final int? totalCustomers;
  final int? totalViews;
  final int? totalFavorites;
  final int? totalAvailableProducts;
  final int? totalActiveProducts;
  DashboardData(
      {this.chart,
      this.revenue,
      this.completedOrders,
      this.canceledOrders,
      this.totalCustomers,
      this.totalViews,
      this.totalFavorites,
      this.totalAvailableProducts,
      this.totalActiveProducts});

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}

@JsonSerializable()
class RevenueItem {
  @JsonKey(name: '_id')
  final String? id;
  final double? totalAmount;
  final int? count;

  String get getPrice {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    if (totalAmount == null) return '0';
    return currencyFormatter.format(totalAmount);
  }

  int get totalAmountItemConver => (totalAmount! ~/ 1000000).toInt();

  RevenueItem({this.id, this.totalAmount, this.count});
  factory RevenueItem.fromJson(Map<String, dynamic> json) =>
      _$RevenueItemFromJson(json);

  Map<String, dynamic> toJson() => _$RevenueItemToJson(this);
}

@JsonSerializable()
class RevenueData {
  final double? totalAmount;
  final int? countCompletedOrder;

  String get getRevenueData {
    if (totalAmount == null) {
      return "0m";
    }

    return NumberFormat('# m', 'ID').format((totalAmount! ~/ 1000000).toInt());
  }

  RevenueData({this.totalAmount, this.countCompletedOrder});
  factory RevenueData.fromJson(Map<String, dynamic> json) =>
      _$RevenueDataFromJson(json);

  Map<String, dynamic> toJson() => _$RevenueDataToJson(this);
}
