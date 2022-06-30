// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorDashboardResponse _$VendorDashboardResponseFromJson(
        Map<String, dynamic> json) =>
    VendorDashboardResponse(
      data: json['data'] == null
          ? null
          : DashboardData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int,
      message: json['message'] as String?,
      errors: json['errors'],
    );

Map<String, dynamic> _$VendorDashboardResponseToJson(
        VendorDashboardResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'status': instance.status,
      'message': instance.message,
      'errors': instance.errors,
    };

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      chart: (json['chart'] as List<dynamic>?)
          ?.map((e) => RevenueItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      revenue: json['revenue'] == null
          ? null
          : RevenueData.fromJson(json['revenue'] as Map<String, dynamic>),
      completedOrders: json['completedOrders'] as int?,
      canceledOrders: json['canceledOrders'] as int?,
      totalCustomers: json['totalCustomers'] as int?,
      totalViews: json['totalViews'] as int?,
      totalFavorites: json['totalFavorites'] as int?,
      totalAvailableProducts: json['totalAvailableProducts'] as int?,
      totalActiveProducts: json['totalActiveProducts'] as int?,
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'chart': instance.chart,
      'revenue': instance.revenue,
      'completedOrders': instance.completedOrders,
      'canceledOrders': instance.canceledOrders,
      'totalCustomers': instance.totalCustomers,
      'totalViews': instance.totalViews,
      'totalFavorites': instance.totalFavorites,
      'totalAvailableProducts': instance.totalAvailableProducts,
      'totalActiveProducts': instance.totalActiveProducts,
    };

RevenueItem _$RevenueItemFromJson(Map<String, dynamic> json) => RevenueItem(
      id: json['_id'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$RevenueItemToJson(RevenueItem instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'totalAmount': instance.totalAmount,
      'count': instance.count,
    };

RevenueData _$RevenueDataFromJson(Map<String, dynamic> json) => RevenueData(
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      countCompletedOrder: json['countCompletedOrder'] as int?,
    );

Map<String, dynamic> _$RevenueDataToJson(RevenueData instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'countCompletedOrder': instance.countCompletedOrder,
    };
