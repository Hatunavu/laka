import 'dart:developer';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/api/constant.dart';
import 'package:client_tggt/model/message/add_message_item_request.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:client_tggt/model/message/message_item_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class VendorMessageDetailController extends GetxController {
  final String title = "message detail";
  final isLoading = false.obs;
  final needsScroll = false.obs;
  final isSendMessage = false.obs;
  final listMessages = <MessageItemModel>[].obs;
  final limit = 20.obs;
  final page = 1.obs;
  final focusNode = FocusNode();
  final isShowKeyboard = false.obs;
  late io.Socket _socket;
  final roomId = "".obs;

  VendorMessageDetailController(this._apiClient);
  ScrollController messageDetailController = ScrollController();
  final chatWithUser = AccountModel().obs;
  final contentMessage = TextEditingController(text: "").obs;

  final ApiClient _apiClient;
  @override
  void onReady() async {
    _connectSocket();
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

  _connectSocket() {
    final userToken = AccountServices().getUserToken().obs;
    final deceiveToken = AccountServices().getNotificationToken();
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
      _socket.emit('subcribe', roomId.value);
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

        final roomUsers = roomInfo.accounts;
        final findUser =
            roomUsers.where((element) => element.id != userId).toList();
        listMessages.value = List.from(messages.reversed);
        chatWithUser.value = findUser[0];
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
}
