import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/notification/widget/notification_shimmer.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:client_tggt/screen/vendors/message/notification/vendor_notification_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VendorListNotification extends StatelessWidget {
  const VendorListNotification({Key? key, required this.notificationController})
      : super(key: key);
  final VendorNotificationController notificationController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => notificationController.isLoading.isTrue
          ? const NotificationShimmer()
          : Container(
              padding: EdgeInsets.zero,
              child: notificationController.listNotification.isNotEmpty
                  ? ListView.builder(
                      itemCount: notificationController.listNotification.length,
                      // controller:
                      //     notificationController.listNotificationController,
                      itemBuilder: (ctx, index) {
                        return renderNotificationItemByType(
                            context,
                            notificationController.listNotification[index],
                            index,
                            notificationController);
                      })
                  : Container(
                      padding: EdgeInsets.only(top: defaultPaddingItem.h * 3),
                      alignment: Alignment.center,
                      child: Text(
                        "noNotofication".tr,
                        style: AppTextStyle().titleRegular16,
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
    );
  }
}

Widget renderNotificationItemByType(
    BuildContext context,
    NotificationModal item,
    int index,
    VendorNotificationController controller) {
  return GestureDetector(
      onTap: () {
        context.router
            .push(BookingDetailPage(
          bookingId: item.ref,
          parentPage: "booking_list",
        ))
            .then((value) {
          Get.delete<BookingDetailController>();
        });
      },
      child: Container(
          padding: EdgeInsets.only(
              left: kDefaultPaddingScreen.w,
              right: kDefaultPaddingScreen.w,
              bottom: 8.h,
              top: 8.h),
          decoration: BoxDecoration(
            color: item.isRead == false
                ? ThemeServices().isDarkMode
                    ? Colors.grey[800]
                    : Colors.grey[200]
                : Theme.of(context).backgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.customerAvatar,
                      memCacheHeight: 200,
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 26,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.content ?? "",
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 14.sp)),
                  SizedBox(height: 5.h),
                  Text(
                      TGGTUtils()
                          .formatToTimeAgo(item.createdAt.toIso8601String()),
                      style: subTitleStyle.copyWith(fontSize: 12.sp)),
                ],
              ))
            ],
          )));
}
