import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/notification/notification_enum.dart';
import 'package:client_tggt/model/notification/notification_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/screen/notification/notification_controller.dart';
import 'package:client_tggt/screen/notification/widget/notification_shimmer.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListNotification extends StatelessWidget {
  const ListNotification({Key? key, required this.notificationController})
      : super(key: key);
  final NotificationController notificationController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => notificationController.isLoading.isTrue
          ? const NotificationShimmer()
          : Container(
              margin: EdgeInsets.only(top: defaultPaddingItem.h),
              padding: EdgeInsets.zero,
              child: notificationController.listNotification.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: notificationController.listNotification.length,
                      controller:
                          notificationController.listNotificationController,
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
    NotificationModal notification,
    int index,
    NotificationController controller) {
  switch (notification.type) {
    case NotificationType.orderSuccess:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: 'notificationBookingSuccess'.tr,
            style: titleStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: notification.displayNotifBy,
                  style: titleStyle.copyWith(fontSize: 14.sp)),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );

    case NotificationType.orderCancled:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: 'notificationOrderAt'.tr,
            style: titleStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: notification.displayNotifBy,
                  style: titleStyle.copyWith(fontSize: 14.sp)),
              TextSpan(
                text: "hasBeenCanceled".tr,
                style: titleStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 14.sp),
              ),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );
    case NotificationType.orderConfirmed:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: 'notificationOrderAt'.tr,
            style: titleStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: notification.displayNotifBy,
                  style: titleStyle.copyWith(fontSize: 14.sp)),
              TextSpan(
                text: "hasBeenConfirmed".tr,
                style: titleStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 14.sp),
              ),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );
    case NotificationType.orderComplete:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: 'notificationOrderAt'.tr,
            style: titleStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: notification.displayNotifBy,
                  style: titleStyle.copyWith(fontSize: 14.sp)),
              TextSpan(
                text: "hasBeenCompleted".tr,
                style: titleStyle.copyWith(
                    fontWeight: FontWeight.normal, fontSize: 14.sp),
              ),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );

    case NotificationType.orderUpdated:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: 'notificationOrderAt'.tr,
            style: titleStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: notification.displayNotifBy,
                  style: titleStyle.copyWith(fontSize: 14.sp)),
              TextSpan(
                  text: "hasBeenChanged".tr,
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14.sp)),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );

    case NotificationType.post:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: 'updateStatus'.tr,
            style: titleStyle,
            children: const <TextSpan>[],
          ),
        ),
        index,
        controller,
        notification,
      );

    case NotificationType.postNewReaction:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: notification.displayNotifBy,
            style: titleStyle.copyWith(fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: "reactPost".tr,
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14.sp)),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );

    case NotificationType.comment:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: notification.displayNotifBy,
            style: titleStyle.copyWith(fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: "commentPost".tr,
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14.sp)),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );

    case NotificationType.chat:
      return notificationItem(
        context,
        RichText(
          maxLines: 2,
          text: TextSpan(
            text: notification.displayNotifBy,
            style: titleStyle.copyWith(fontSize: 14.sp),
            children: <TextSpan>[
              TextSpan(
                  text: "mesToU".tr,
                  style: titleStyle.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14.sp)),
            ],
          ),
        ),
        index,
        controller,
        notification,
      );
    default:
      return Container();
  }
}

Widget notificationItem(BuildContext context, Widget content, int index,
    NotificationController controller, NotificationModal item) {
  return GestureDetector(
      onTap: () {
        if (item.isRead == false) {
          controller.updateReadNotification(false, item.id);
        }
        if (item.order != null) {
          context.router
              .push(ActivityDetailPage(id: item.ref, isFromQr: false));
        } else if (item.post != null) {
          context.router
              .push(NewfeedDetailPage(postId: item.ref, isFocus: false));
        }
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
                    ? kColorBackgroundDark.withOpacity(.1)
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
                      imageUrl: item.displayAvatar,
                      memCacheHeight: 200,
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 26,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: item.order != null
                            ? Container(
                                padding: const EdgeInsets.all(3),
                                width: 20.w,
                                height: 20.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                child: Image.asset(
                                  getPathIcon(item.order!.vendor!.category),
                                  color: Theme.of(context).backgroundColor,
                                ),
                              )
                            : Container()),
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
                  content,
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
