import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors/message/notification/vendor_notification_controller.dart';
import 'package:client_tggt/screen/vendors/message/notification/widget/vendor_list_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VendorNotification extends StatelessWidget {
  const VendorNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorNotificationController controller =
        Get.put(VendorNotificationController(getIt.get<ApiClient>()));
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Expanded(
              child: VendorListNotification(
            notificationController: controller,
          )),
          Container()
        ],
      ),
    );
  }
}
