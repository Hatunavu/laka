import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor_page/dashboard/vendor_dashboard_response.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DashboardTimerType {
  final int id;
  final String title;
  DashboardTimerType({required this.id, required this.title});
}

class VendorsHomeController extends GetxController {
  final String title = "vendor_home";
  final isLoading = false.obs;
  final isShowChangeTime = false.obs;
  final listStatus = ["Hôm nay", "7 Ngày", "30 Ngày", "Tuỳ chỉnh"].obs;
  final selectedIndex = 0.obs;
  final userId = AccountServices().getUserId().obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;
  final Rx<AccountModel> account = AccountModel().obs;
  final RxList<DashboardTimerType> listTimerType = RxList<DashboardTimerType>();
  final RxList<RevenueItem> chartData = RxList<RevenueItem>();
  final revenueData = RevenueData().obs;
  final listTimeType = [];
  final completedOrders = 0.obs;
  final canceledOrders = 0.obs;
  final totalCustomers = 0.obs;
  final totalViews = 0.obs;
  final totalFavorites = 0.obs;
  final totalAvailableProducts = 0.obs;
  final totalActiveProducts = 0.obs;

  VendorsHomeController(this._apiClient);
  final ApiClient _apiClient;

  @override
  void onInit() {
    final getStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

    handleGetVendorDashboard(getStartDate, "");
    super.onInit();
  }

  changeSelectedIndex(int index) {
    selectedIndex.value = index;
    if (index == 0) {
      final getStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      startDate.value = DateTime.now();
      endDate.value = DateTime.now();
      isShowChangeTime.value = false;
      handleGetVendorDashboard(getStartDate, "");
    }
    if (index == 1) {
      startDate.value = DateTime.now();
      endDate.value = DateTime.now();
      final getMiniseconds =
          DateTime.now().millisecondsSinceEpoch - (86400000 * 7);
      final DateTime getStartDate =
          DateTime.fromMillisecondsSinceEpoch(getMiniseconds);
      handleGetVendorDashboard('$getStartDate', '${DateTime.now()}');
    }
    if (index == 2) {
      startDate.value = DateTime.now();
      endDate.value = DateTime.now();
      final getMiniseconds =
          DateTime.now().millisecondsSinceEpoch - (86400000 * 30);
      final DateTime getStartDate =
          DateTime.fromMillisecondsSinceEpoch(getMiniseconds);
      handleGetVendorDashboard('$getStartDate', '${DateTime.now()}');
    }
    if (index == 3) {
      startDate.value = DateTime.now();
      endDate.value = DateTime.now();
      final getMiniseconds =
          DateTime.now().millisecondsSinceEpoch - (86400000 * 365);
      final DateTime getStartDate =
          DateTime.fromMillisecondsSinceEpoch(getMiniseconds);
      handleGetVendorDashboard('$getStartDate', '${DateTime.now()}');
    }
  }

  handleAddListDasboardTimerType() {
    listTimerType.add(DashboardTimerType(id: 0, title: "Hôm qua"));
    listTimerType.add(DashboardTimerType(id: 0, title: "7 ngày vừa qua"));
    listTimerType.add(DashboardTimerType(id: 0, title: "30 ngày vừa qua"));
  }

  handleGetVendorDashboard(String startDate, String endDate) async {
    try {
      isLoading(true);
      final response = await _apiClient.getVendorDashboard(startDate, endDate);
      if (response.status == 200) {
        final data = response.data;
        if (data != null) {
          chartData.value = data.chart ?? [];
          if (data.revenue != null) {
            revenueData.value = data.revenue!;
          }
          completedOrders.value = data.completedOrders ?? 0;
          canceledOrders.value = data.canceledOrders ?? 0;
          totalCustomers.value = data.totalCustomers ?? 0;
          totalViews.value = data.totalViews ?? 0;
          totalFavorites.value = data.totalFavorites ?? 0;
          totalAvailableProducts.value = data.totalAvailableProducts ?? 0;
          totalActiveProducts.value = data.totalActiveProducts ?? 0;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleGetVendorDashboardByTime() async {
    handleGetVendorDashboard('$startDate', '$endDate');
    isShowChangeTime.value = false;
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      if (args.value.startDate != null) {
        print(args.value.startDate);
        startDate.value = args.value.startDate;
      }
      if (args.value.endDate != null) {
        endDate.value = args.value.endDate;
      }
    }
    // setState(() {
    //   if (args.value is PickerDateRange) {
    //     _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
    //         // ignore: lines_longer_than_80_chars
    //         ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    //   } else if (args.value is DateTime) {
    //     _selectedDate = args.value.toString();
    //   } else if (args.value is List<DateTime>) {
    //     _dateCount = args.value.length.toString();
    //   } else {
    //     _rangeCount = args.value.length.toString();
    //   }
    // });
  }

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
