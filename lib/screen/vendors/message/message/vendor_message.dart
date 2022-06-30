import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:client_tggt/screen/vendors/message/message/vendor_message_controller.dart';
import 'package:client_tggt/screen/vendors/message/message/widget/vendor_message_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorMessage extends StatelessWidget {
  const VendorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorMessageController controller =
        Get.put(VendorMessageController(getIt.get<ApiClient>()));
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(child: renderListMessage(context, controller)),
            Container()
          ],
        ),
      ),
    );
  }
}

Widget renderListMessage(
    BuildContext context, VendorMessageController controller) {
  return Obx(() => controller.listMessage.isEmpty
      ? Container(
          alignment: Alignment.center,
          child: Text("noMessage".tr),
        )
      : ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          primary: false,
          // ignore: invalid_use_of_protected_member
          itemCount: controller.listMessage.value.length,
          itemBuilder: (context, int index) {
            final MessageItemInList item = controller.listMessage[index];
            return VendorMessageItem(
                message: item, index: index, controller: controller);
          }));
}
