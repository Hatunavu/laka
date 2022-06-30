import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/notification/notification_controller.dart';
import 'package:client_tggt/screen/notification/widget/list_notification.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';

class CustomerNotification extends StatelessWidget {
  const CustomerNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationController notificationController =
        Get.put(NotificationController(getIt.get<ApiClient>()));
    notificationController.getListNotification();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            renderHeader(context),
            Expanded(
                child: ListNotification(
              notificationController: notificationController,
            )),
            Container()
          ],
        ),
      ),
    );
  }
}

Widget renderHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(0.w, 38.h, kDefaultPaddingWidget.w, 0.h),
    decoration: BoxDecoration(
        color: ThemeServices().isDarkMode
            ? kColorBackgroundDark
            : kColorPrimaryLight),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      context.router.pop();
                    },
                    icon: Icon(
                      Ionicons.chevron_back_outline,
                      size: 20.sp,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : Colors.white,
                    )),
                SizedBox(
                  width: 0.w,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6.h),
                  child: Text("notification".tr,
                      style: titleStyle.copyWith(
                          fontSize: 17.sp,
                          color: ThemeServices().isDarkMode
                              ? Colors.black
                              : Colors.white)),
                )
              ],
            ),
            InkWell(
              onTap: () {},
              child: Icon(
                Ionicons.search_outline,
                size: 23,
                color: ThemeServices().isDarkMode
                    ? kColorPrimaryDark
                    : Colors.white,
              ),
            )
          ],
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
      ],
    ),
  );
}
