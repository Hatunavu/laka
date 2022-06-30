import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/message/get_list_message_response.dart';
import 'package:client_tggt/screen/profile/message/message_controller.dart';
import 'package:client_tggt/screen/profile/message/widget/message_item.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageController controller =
        Get.put(MessageController(getIt.get<ApiClient>()));
    controller.getListMessage();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            renderHeader(context),
            Expanded(child: renderListMessage(context, controller)),
            Container()
          ],
        ),
      ),
    );
  }
}

Widget renderHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(0.w, 38.h, 16.w, 0.h),
    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
                          ? Colors.black
                          : Colors.white,
                    )),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: Text(
                    "Message",
                    style: titleStyle.copyWith(
                        fontSize: 17.sp,
                        color: ThemeServices().isDarkMode
                            ? Colors.black
                            : Colors.white),
                  ),
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

Widget renderListMessage(BuildContext context, MessageController controller) {
  return Obx(() => controller.isLoading.isTrue
      ? const LoadingScreen()
      : controller.listMessage.isEmpty
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
                return MessageItemWidget(
                  message: item,
                  index: index,
                  controller: controller,
                );
              }));
}
