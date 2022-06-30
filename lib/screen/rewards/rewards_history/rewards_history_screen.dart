import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/rewards/reward_model.dart';
import 'package:client_tggt/screen/rewards/rewards_history/rewards_history_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class RewardsHistoryScreen extends StatelessWidget {
  const RewardsHistoryScreen({Key? key}) : super(key: key);
// RewardsModel

  @override
  Widget build(BuildContext context) {
    final RewardsHistoryController controller =
        Get.put(RewardsHistoryController(getIt.get<ApiClient>()));
    return BaseScreen(
      title: "pointHistory2".tr,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            size: 23,
            color:
                ThemeServices().isDarkMode ? kColorPrimaryDark : Colors.black,
          )),
      child: Obx(() => controller.isLoading.isTrue
          ? const LoadingScreen()
          : Container(
              padding: EdgeInsets.zero,
              child: controller.listRewardsHistory.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      child: Text(
                        "notHavePointHistory".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeServices().isDarkMode
                                ? kColorGreyDark
                                : kColorPrimaryLight,
                            fontSize: 15.sp,
                            height: 1.5),
                      ),
                    )
                  : renderHistory(context, controller),
            )),
    );
  }
}

Widget renderHistory(
    BuildContext context, RewardsHistoryController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: controller.listRewardsHistory.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (ctx, index) {
        final RewardsModel item = controller.listRewardsHistory[index];
        return Container(
          padding: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.2.h, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.order.bookingTime,
                    style: subTitleStyle,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    'order'.tr + ' ${item.order.bookingCode}',
                    style: titleStyle.copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.zero,
                child: Text(
                  item.type == "add"
                      ? '+${TGGTUtils().formatNumber(item.amount)}'
                      : '-${TGGTUtils().formatNumber(item.amount)}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: item.type == "add" ? Colors.green : Colors.red),
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
