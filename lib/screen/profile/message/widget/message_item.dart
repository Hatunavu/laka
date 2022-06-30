import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/screen/profile/message/message_controller.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget(
      {Key? key,
      required this.message,
      required this.index,
      required this.controller})
      : super(key: key);
  final MessageItemInList message;
  final int index;
  final MessageController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router
            .push(MessageDetailPage(roomId: message.id, vendorId: ""))
            .then((value) async {
          // final MessageDetailController messageDetailController =
          //     Get.put(MessageDetailController(getIt.get<ApiClient>()));
          // await messageDetailController.disposeSocket();
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
                    imageUrl: message.urlAvatar ??
                        "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png",
                    memCacheHeight: 200,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 26,
                    ),
                  ),
                  Visibility(
                      visible: message.vendor != null,
                      child: Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2.5),
                            width: 18.w,
                            height: 18.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                color: Theme.of(context).primaryColor),
                            child: Image.asset(
                              getPathIcon(message.getCategory),
                              color: Theme.of(context).backgroundColor,
                            ),
                          ))),
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
                      message.fullname,
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
