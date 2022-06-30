import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:client_tggt/screen/vendors/message/message/vendor_message_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';

class VendorMessageItem extends StatelessWidget {
  const VendorMessageItem(
      {Key? key,
      required this.message,
      required this.index,
      required this.controller})
      : super(key: key);
  final MessageItemInList message;
  final int index;
  final VendorMessageController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router
            .push(MessageDetailPage(roomId: message.id, vendorId: ""))
            .then((value) async {
          Get.delete<MessageDetailController>();
          controller.getListMessage();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingScreen.w, vertical: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: message.getAvatarVendor ?? "",
                    memCacheHeight: 200,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 26,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPaddingWidget.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.getFullNameVendor ?? "",
                      maxLines: 1,
                      style: titleStyle.copyWith(fontSize: 14.sp),
                    ),
                    Text(
                      message.message ?? "",
                      maxLines: 1,
                      style: subTitleStyle.copyWith(fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                child: Text(
                  message.displayMessageTime,
                  style: subTitleStyle.copyWith(fontSize: 12.sp),
                ))
          ],
        ),
      ),
    );
  }
}
