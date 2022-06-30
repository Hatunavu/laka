import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final String title = "notification";
  final listNotification = <NotificationModal>[].obs;
  final isLoading = false.obs;
  final isEmptyNotification = false.obs;
  final page = 1.obs;
  final limit = 20.obs;
  final totalDocs = 0.obs;
  NotificationController(this._apiClient);
  final ApiClient _apiClient;
  ScrollController listNotificationController = ScrollController();

  @override
  void onInit() {
    listNotificationController.addListener(listenLoadMoreNotification);

    super.onInit();
  }

  listenLoadMoreNotification() {
    if (listNotificationController.offset ==
        listNotificationController.position.maxScrollExtent) {
      if (listNotification.length < totalDocs.value) {
        // getMoreListPost();
        getMoreNotifications();
      }
    }
  }

  getMoreNotifications() async {
    try {
      final response =
          await _apiClient.getListNotification(limit.value, page.value + 1);
      if (response.status == 200) {
        page.value = page.value + 1;
        listNotification.value = [
          ...listNotification,
          ...response.data.docs ?? []
        ];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  getListNotification() async {
    try {
      isLoading(true);
      final response =
          await _apiClient.getListNotification(limit.value, page.value);
      if (response.status == 200) {
        if (response.data.docs!.isEmpty) {
          isEmptyNotification.value = true;
        } else {
          final data = response.data;
          final docs = data.docs;
          listNotification.value = docs ?? [];
          totalDocs.value = data.totalDocs ?? 0;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  updateReadNotification(bool isReadAll, String refId) async {
    try {
      isLoading(true);
      final statusReadAll = isReadAll == true ? '1' : '0';
      final response =
          await _apiClient.updateReadNotification(statusReadAll, refId);
      if (response.status == 200) {
        var newList = listNotification.map((item) {
          if (item.id == refId) {
            item.isRead = true;
            return item;
          } else {
            return item;
          }
        }).toList();
        listNotification.value = newList;
        final MainController mainController =
            Get.put(MainController(getIt.get<ApiClient>()));
        mainController.handleUpdateCountUnreadNotification(1);
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }
}
