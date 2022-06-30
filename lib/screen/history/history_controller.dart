import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/activity/activity_screen_response.dart';
import 'package:client_tggt/model/activity/data.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  var listHistory = DataListActivity().obs;
  final ApiClient _apiClient;
  var categoryValue = 'all'.tr.obs;
  var statusValue = HistoryStatus.all.obs;
  var statusParam = "pending,canceled,completed,confirmed,checkedIn";
  var limit = 10;
  var page = 1;
  var isLoading = false.obs;

  HistoryController(this._apiClient);

  @override
  void onInit() {
    super.onInit();
    //getList on init
    setStatus(HistoryStatus.all);
    //on Tab Change
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   //getList on init
  //   //on Tab Change
  // }

  Future<bool> handleDisposeRefreshController() async {
    refreshController.dispose();
    return true;
  }

  void onRefresh() async {
    // monitor network fetch
    page = 1;
    _getListOrders(limit, page, statusParam, false);
    // if failed,use refreshFailed()
  }

  void onLoading() async {
    // monitor network fetch
    page += 1;
    _getListOrders(limit, page, statusParam, true);
  }

  setStatus(HistoryStatus value) {
    switch (value) {
      case HistoryStatus.completed:
        statusParam = HistoryStatus.completed.toJsonString();
        statusValue.value = HistoryStatus.completed;
        break;
      case HistoryStatus.canceled:
        statusParam = HistoryStatus.canceled.toJsonString();
        statusValue.value = HistoryStatus.canceled;
        break;
      case HistoryStatus.all:
        statusParam = HistoryStatus.all.toJsonString();
        statusValue.value = HistoryStatus.all;
        break;
      case HistoryStatus.pending:
        statusParam = HistoryStatus.pending.toJsonString();
        statusValue.value = HistoryStatus.pending;
        break;
      case HistoryStatus.confirmed:
        statusParam = HistoryStatus.confirmed.toJsonString();
        statusValue.value = HistoryStatus.confirmed;
        break;
      case HistoryStatus.checkedIn:
        statusParam = HistoryStatus.checkedIn.toJsonString();
        statusValue.value = HistoryStatus.checkedIn;
        break;
    }
    onRefresh();
  }

  _getListOrders(int limit, int page, String status, bool isLoadMore) async {
    try {
      isLoading(true);
      var response = await _apiClient.getListOrders(limit, page, "", status);
      if (response.status == 200) {
        //log("getListVendors: ${data.data.hotVendors.toString()}");
        if (response.data != null) {
          if (response.data!.docs!.isNotEmpty) {
            if (isLoadMore) {
              listHistory.value.docs!.addAll(response.data!.docs!);
              listHistory.refresh();
              refreshController.loadComplete();
            } else {
              listHistory.value = response.data!;
              refreshController.refreshCompleted();
            }
          } else {
            if (isLoadMore) {
              refreshController.loadNoData();
            } else {
              listHistory.value = response.data!;
            }
          }
        } else {
          refreshController.loadFailed();
          refreshController.refreshFailed();
        }
      }
      refreshController.refreshCompleted();
    } on Exception catch (err) {
      log("err $err");
    } finally {
      refreshController.refreshCompleted();
      isLoading(false);
    }
  }
}

enum HistoryStatus { all, canceled, completed, confirmed, pending, checkedIn }

extension HistoryStatusExt on HistoryStatus {
  String toJsonString() {
    switch (this) {
      case HistoryStatus.all:
        return "pending,canceled,completed,confirmed,checkedIn";
      case HistoryStatus.canceled:
        return "canceled";
      case HistoryStatus.completed:
        return "completed";
      case HistoryStatus.confirmed:
        return "confirmed";
      case HistoryStatus.pending:
        return "pending";
      case HistoryStatus.checkedIn:
        return "checkedIn";
    }
  }

  String display() {
    switch (this) {
      case HistoryStatus.all:
        return "all".tr;
      case HistoryStatus.canceled:
        return "canceled".tr;
      case HistoryStatus.completed:
        return "completed".tr;
      case HistoryStatus.checkedIn:
        return "checkedIn".tr;
      case HistoryStatus.pending:
        return 'processing'.tr;
      case HistoryStatus.confirmed:
        return 'confirm'.tr;
    }
  }
}

HistoryStatus stringToHistoryStatus(String status) {
  switch (status) {
    case 'all':
      return HistoryStatus.all;
    case 'canceled':
      return HistoryStatus.canceled;
    case 'completed':
      return HistoryStatus.completed;
    case "checkedIn":
      return HistoryStatus.checkedIn;
    case "pending":
      return HistoryStatus.pending;
    case "confirmed":
      return HistoryStatus.confirmed;
    default:
      return HistoryStatus.all;
  }
}

String historyStatusToString(HistoryStatus status) {
  switch (status) {
    case HistoryStatus.all:
      return 'completed,canceled,checkedIn,pending,confirmed';
    case HistoryStatus.pending:
      return 'pending';
    case HistoryStatus.confirmed:
      return 'confirmed';
    case HistoryStatus.completed:
      return 'completed';
    case HistoryStatus.canceled:
      return "canceled";
    case HistoryStatus.checkedIn:
      return "checked-in";
  }
}
