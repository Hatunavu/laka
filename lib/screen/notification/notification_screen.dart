import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/notification/customer_notification.dart';
import 'package:client_tggt/shared/not_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController =
        Get.put(MainController(getIt.get<ApiClient>()));
    return mainController.userToken.value == ""
        ? NotLoginScreen(
            title: "loginToSeeNotificationTitle".tr,
            subTitle: "loginToSeeNotificationLabel".tr)
        : const CustomerNotification();
    // : DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         backgroundColor: Theme.of(context).backgroundColor,
    //         automaticallyImplyLeading: false,
    //         titleTextStyle: Theme.of(context)
    //             .textTheme
    //             .headline6!
    //             .copyWith(color: appBarTitleColor),
    //         centerTitle: true,
    //         bottom: TabBar(
    //           labelColor: Theme.of(context).primaryColor,
    //           labelStyle: AppTextStyle().titleRegular16,
    //           unselectedLabelColor: ThemeServices().isDarkMode
    //               ? kColorGreyDark
    //               : kColorGreyLight,
    //           unselectedLabelStyle: AppTextStyle().subtitleRegular14,
    //           indicatorColor: Theme.of(context).primaryColor,
    //           tabs: [
    //             Tab(
    //               text: "notification".tr,
    //             ),
    //             Tab(text: "message".tr),
    //           ],
    //         ),
    //         title: Text('notification'.tr),
    //       ),
    //       body: const TabBarView(
    //         physics: NeverScrollableScrollPhysics(),
    //         children: [CustomerNotification(), MessageScreen()],
    //       ),
    //     ),
    //   );
  }
}
