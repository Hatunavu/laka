import 'dart:developer';
import 'dart:ffi';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/detail_option/datum.dart';
import 'package:client_tggt/model/order/order_request/option.dart';
import 'package:client_tggt/model/order/order_request/order_request.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/model/voucher/enum_voucher_status.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderController extends GetxController {
  DatePickerController datePickerController = DatePickerController();
  PageController pageController = PageController(initialPage: 1);
  // var textfieldController = TextEditingController();

  var listOption = <Datum>[].obs;
  var selectedProduct = <Option>[].obs;

  var isSelectDate = false.obs;
  var isSelectTime = true.obs;
  var calendarFormat = CalendarFormat.week.obs;
  var selectedDay = TGGTUtils().formatDateFromDateTime(DateTime.now()).obs;
  var selectedRequestDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var serviceID = "".obs;
  var focusedTime = DateTime.now().obs;
  var selectedTime = TGGTUtils()
      .formatDateTimeToTime(DateTime.now().add(const Duration(hours: 1)))
      .obs;
  var selectedRequestTime = DateTime.now().obs;
  var selectHour = TGGTUtils()
      .formatDateTimeToHour(DateTime.now().add(const Duration(hours: 1)))
      .obs;
  var selectMinute = TGGTUtils()
      .formatDateTimeToMinute(DateTime.now().add(const Duration(hours: 1)))
      .obs;
  var isSelectNumber = false.obs;
  var personCount = 1.obs;
  var isLoading = false.obs;
  var isSuccess = false;
  var morningTimes = <String>[].obs;
  var timeList = <DateTime>[];
  final ApiClient _apiClient;
  var timeSelectValue = 0.obs;
  var clientNote = ''.obs;
  var preCalculatePrice = ''.obs;
  var preCalculatePriceWithDiscount = ''.obs;
  final isSelectedVoucher = false.obs;

  // var haveService = false.obs;
  final selectedVoucher = VoucherModel(
          id: "",
          discount: DiscountVoucherModel(type: "system", amount: 0),
          title: "",
          active: false,
          code: "",
          status: VoucherStatusType.expireDate,
          type: VoucherType.system)
      .obs;

  OrderController(this._apiClient);

  checkAdditionalService() {
    selectedProduct.value = [];
    for (var item in listOption) {
      if (item.quantity != 0 || item.isSelect != false) {
        var option = Option(
          id: item.id,
          amount: item.quantity == 0 ? 1 : item.quantity,
        );
        selectedProduct.add(option);
      }
    }
  }

  void initTimes() {
    var startTime = DateTime.now();
    var hour = startTime.hour;
    var minute = startTime.minute;
    if (startTime.day == selectedRequestDay.value.day &&
        startTime.month == selectedRequestDay.value.month &&
        startTime.year == selectedRequestDay.value.year) {
      if (hour < 9) {
        hour = 9;
      } else {
        minute += 30;
        if (minute >= 60) {
          minute = 0;
          hour++;
        } else {
          minute = 30;
        }
      }
    } else {
      hour = 9;
      minute = 0;
    }

    if (hour > 22 && minute > 45 || hour == 23 && minute <= 59) {
      morningTimes.value = ['Hết\nchỗ'];
      timeList = [];
      selectedRequestTime.value = startTime;
    } else {
      var listDateTime = <DateTime>[];
      var listDateString = getTimes(TimeOfDay(hour: hour, minute: minute),
              const TimeOfDay(hour: 23, minute: 0), const Duration(minutes: 30))
          .map((e) {
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, e.hour, e.minute);
        final format = DateFormat.jm(); //"6:00 AM"
        final result = format.format(dt).split(" ");

        listDateTime.add(dt);

        return '${result.first}\n${result.last}';
      }).toList();
      morningTimes.value = listDateString;
      morningTimes.refresh();
      timeList = listDateTime;
      selectedRequestTime.value = timeList.first;
    }
  }

  String splitText(String string) {
    var result = string.split("\n");
    return '${result.first} ${result.last}';
  }

  OrderRequest generateDataRequest() {
    DateTime requestDate = DateTime(
        selectedRequestDay.value.year,
        selectedRequestDay.value.month,
        selectedRequestDay.value.day,
        selectedRequestTime.value.hour,
        selectedRequestTime.value.minute);
    String orderAt = requestDate.toIso8601String();
    return OrderRequest(
        productId: serviceID.value,
        orderAt: orderAt,
        note: clientNote.value,
        totalPeople: personCount.value,
        options: selectedProduct,
        voucherId: selectedVoucher.value.id);
  }

  Future<String> requestOrder() async {
    return await _postOrder(generateDataRequest());
  }

  Future<bool> requestPreCalculate() async {
    final result = await _postPreCalculate(generateDataRequest());
    return result;
  }

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  setSelectTime() {
    if (isSelectTime.value == true) {
      isSelectDate.value = false;
    }
  }

  setSelectDate() {
    if (isSelectDate.value == true) {
      isSelectTime.value = false;
    }
  }

  buildTime() {
    DateTime resultTime = DateTime(
        selectedRequestTime.value.year,
        selectedRequestTime.value.month,
        selectedRequestTime.value.day,
        selectHour.value,
        selectMinute.value);
    selectedTime.value = TGGTUtils().formatDateTimeToTime(resultTime);
  }

  Future<String> _postOrder(OrderRequest data) async {
    try {
      isLoading(true);
      var response = await _apiClient.postOrder(data);
      if (response.status == 200) {
        if (response.data != null) {
          isSuccess = true;
          final MainController mainController = Get.find();
          mainController.handleUpdateCurrentOrder(response.data!);
          return response.data?.id ?? '';
        }
        isSuccess = false;
        return '';
      } else {
        isSuccess = false;
        return '';
      }
    } on Exception catch (err) {
      log("err $err");
      isSuccess = false;
      return '';
    } finally {
      isLoading(false);
    }
  }

  getDetailOption(String productId) async {
    try {
      isLoading(true);
      var response = await _apiClient.getDetailOption(productId);
      if (response.status == 200) {
        listOption.value = response.data ?? listOption;
      } else {}
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  Future<bool> _postPreCalculate(OrderRequest data) async {
    try {
      isLoading(true);
      var response = await _apiClient.postPreOrderCalculate(data);
      if (response.status == 200) {
        if (response.data != null) {
          preCalculatePrice.value =
              TGGTUtils().formatMoney(response.data?.totalPrice ?? 0) + ' đ';
          final data = response.data;
          if (data != null) {
            preCalculatePriceWithDiscount.value =
                TGGTUtils().formatMoney(data.getPrePriceWithDiscount) + ' đ';
          }

          return true;
        }
        return false;
      }
      return false;
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
    return false;
  }
}
