import 'dart:developer';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/api/constant.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/message/add_message_item_request.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:client_tggt/model/message/message_item_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class MessageDetailController extends GetxController {
  final String title = "message detail";
  final isLoading = false.obs;
  final isConnectSocket = false.obs;
  final needsScroll = false.obs;
  final isSendMessage = false.obs;
  final listMessages = <MessageItemModel>[].obs;
  final limit = 20.obs;
  final page = 1.obs;
  final focusNode = FocusNode();
  final isShowKeyboard = false.obs;
  late io.Socket _socket;
  final roomId = "".obs;
  final isShowOptions = false.obs;
  MessageDetailController(this._apiClient);
  ScrollController messageDetailController = ScrollController();
  final chatWithUser = AccountModel().obs;
  final contentMessage = TextEditingController(text: "").obs;
  final orderCode = "".obs;
  final orderId = "".obs;
  final orderStatus = BookingStatus.confirmed.obs;
  final orderPrice = 0.0.obs;
  final productThumbnail = "".obs;
  final listStaff = <StaffModel>[].obs;
  final isHaveStaff = false.obs;
  final totalStaffPrice = 0.0.obs;
  final vendorInfo = VendorModel(
          brandName: "",
          address:
              VendorAddressModel(fullAddress: "", location: VendorLocaltion()),
          category: CategoryType.karaoke)
      .obs;
  final orderInfo = BookingItemModel(status: BookingStatus.pending).obs;
  final isOrder = false.obs;
  final ApiClient _apiClient;
  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus == true) {
        Future.delayed(const Duration(milliseconds: 100), () {
          messageDetailController.jumpTo(
            messageDetailController.position.maxScrollExtent,
          );
          isShowOptions.value = false;
        });
      } else {
        handleScrollToBottom();
      }
      messageDetailController.jumpTo(
        messageDetailController.position.maxScrollExtent,
      );
    });
    super.onInit();
  }

  updateRoomId(String id) {
    roomId.value = id;
  }

  _connectSocket(String roomId) {
    final userToken = AccountServices().getUserToken().obs;
    final deceiveToken = AccountServices().getNotificationToken();
    isConnectSocket.value = true;
    final options = io.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setAuth({"token": 'Bearer $userToken'})
        // .setQuery({"token": 'Bearer $userToken'})
        .build();
    _socket = io.io(ApiConstants.host, options);
    _socket.connect();
    _socket.onConnect((data) {
      //log(data);

      _socket.emit('identity', deceiveToken);
      _socket.emit('subcribe', roomId);
    });

    _socket.on("messageChanges", (response) {
      final socketResponse =
          SocketMessageResponse.fromJson(response as Map<String, dynamic>);
      final newMessage = socketResponse.message;
      final userId = AccountServices().getUserId();
      if (newMessage.by.id == userId) {
        newMessage.isSender = true;
      } else {
        newMessage.isSender = false;
      }
      listMessages.add(newMessage);
      Future.delayed(const Duration(milliseconds: 100), () {
        messageDetailController.jumpTo(
          messageDetailController.position.maxScrollExtent,
        );
      });
    });
  }

  disposeSocket() {
    _socket.dispose();
  }

  @override
  void onClose() {
    _socket.dispose();
    super.onClose();
  }

  checkStaff(String vendorId) async {
    try {
      isLoading.value = true;
      final response = await _apiClient.customerGetListStaff(vendorId);
      if (response.status == 200) {
        final data = response.data.docs;
        listStaff.value = data ?? [];
        if (data != null) {
          if (data.isNotEmpty) {
            isHaveStaff.value = true;
          }
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  getListMessage(String chatRoomId) async {
    try {
      isLoading.value = true;
      final response = await _apiClient.getListMessageDetail(
          chatRoomId, limit.value, page.value);
      if (response.status == 200) {
        final data = response.data.messages.docs;
        final roomInfo = response.data.roomInfo;
        final userId = AccountServices().getUserId();
        final messages = data.map((item) {
          if (item.by.id == userId) {
            item.isSender = true;
            return item;
          } else {
            item.isSender = false;
            return item;
          }
        }).toList();
        if (roomInfo.ref != null) {
          isOrder.value = true;
          vendorInfo.value = roomInfo.ref!.vendor!;
          orderId.value = roomInfo.ref!.id ?? "";
          listStaff.value = roomInfo.ref!.staffs ?? [];
          totalStaffPrice.value = roomInfo.ref!.totalStaffPrice;
          orderCode.value = response.getBookingId;
          orderStatus.value = response.getBookingStatus;
          orderPrice.value = response.getBookingPrice;
          productThumbnail.value = response.getProductImage;
          checkStaff(roomInfo.ref!.vendor!.id ?? "");
        } else {
          isOrder.value = false;
        }
        final roomUsers = roomInfo.accounts;
        final findUser =
            roomUsers.where((element) => element.id != userId).toList();
        listMessages.value = List.from(messages.reversed);
        chatWithUser.value = findUser[0];
        _connectSocket(chatRoomId);
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
      Future.delayed(const Duration(milliseconds: 300), () {
        messageDetailController.jumpTo(
          messageDetailController.position.maxScrollExtent,
        );
      });
    }
  }

  handleGetChatRoomByVendorId(String vendorId) async {
    try {
      final response = await _apiClient.getChatRoomWithVendor(vendorId);
      if (response.status == 200) {
        final data = response.data;
        if (data == null) {
        } else {
          updateRoomId(data);
          getListMessage(data);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  handleScrollToBottom() {
    messageDetailController.jumpTo(
      messageDetailController.position.maxScrollExtent,
    );
  }

  handleSendMessage() async {
    if (contentMessage.value.text == "") return;
    try {
      isSendMessage.value = true;
      final request = AddMessageItemRequest(content: contentMessage.value.text);
      final response =
          await _apiClient.postAddMessageItem(roomId.value, request);
      if (response.status == 200) {
        contentMessage.value.text = "";
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isSendMessage.value = false;
    }
  }

  handleSendFirstMessage(String vendorId) async {
    if (contentMessage.value.text == "") return;
    try {
      isSendMessage.value = true;
      final request = AddMessageItemRequest(content: contentMessage.value.text);
      final response = await _apiClient.createChatWithVendor(vendorId, request);
      if (response.status == 200) {
        contentMessage.value.text = "";

        final data = response.data.messages.docs;
        final roomInfo = response.data.roomInfo;
        final userId = AccountServices().getUserId();
        final messages = data.map((item) {
          if (item.by.id == userId) {
            item.isSender = true;
            return item;
          } else {
            item.isSender = false;
            return item;
          }
        }).toList();
        final roomUsers = roomInfo.accounts;
        final findUser =
            roomUsers.where((element) => element.id != userId).toList();
        listMessages.value = List.from(messages.reversed);
        chatWithUser.value = findUser[0];
        final chatRoomId = roomInfo.id;
        _connectSocket(chatRoomId);
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isSendMessage.value = false;
    }
  }
}
