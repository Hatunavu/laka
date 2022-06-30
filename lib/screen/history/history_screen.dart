import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/screen/activity/widget/drop_down_list_button.dart';
import 'package:client_tggt/screen/activity/widget/pull_to_refresh_list.dart';
import 'package:client_tggt/screen/history/history_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryController controller =
        Get.put(HistoryController(getIt.get<ApiClient>()));
    // controller.refreshController = RefreshController(initialRefresh: false);
    return BaseScreen(
      elevation: kdefaultElevated,
      backgroundColor: Theme.of(context).backgroundColor,
      title: 'history'.tr,
      leading: IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: Icon(Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: kDefaultPaddingScreen.h),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
              child: buildFilters(context, controller),
            ),
            Expanded(child: buildHistoryView(controller)),
          ],
        ),
      ),
    );
  }

  SizedBox buildFilters(BuildContext context, HistoryController controller) {
    return SizedBox(
      height: 45.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    'categoryType'.tr,
                    style: AppTextStyle().eyebrowRegular10,
                  ),
                ),
                Obx(
                  () => buildCategoryFilter(controller),
                ),
              ],
            ),
          ),
          SizedBox(width: kDefaultPaddingWidget.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    'status'.tr,
                    style: AppTextStyle().eyebrowRegular10,
                  ),
                ),
                Obx(
                  () => buildStatusFilter(context, controller),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DropDownListButton<String> buildCategoryFilter(HistoryController controller) {
    return DropDownListButton<String>(
      listItem: ['all'.tr, ...CategoryType.values.map((e) => e.display())],
      selectedValue: controller.categoryValue.value,
      onChanged: (value) => controller.categoryValue.value = value ?? '',
    );
  }

  DropdownButtonHideUnderline buildStatusFilter(
      BuildContext context, HistoryController controller) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<HistoryStatus>(
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        icon: Padding(
          padding: EdgeInsets.only(left: 4.0.w),
          child: Icon(
            CupertinoIcons.chevron_down,
            color: Theme.of(context).primaryColor,
            size: 14,
          ),
        ),
        items: HistoryStatus.values
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.display(),
                  style: AppTextStyle().subtitleRegular14,
                ),
              ),
            )
            .toList(),
        value: controller.statusValue.value,
        onChanged: (value) {
          controller.setStatus(value ?? HistoryStatus.all);
        },
        focusColor: Theme.of(context).backgroundColor,
        buttonHeight: kDefaultButtonHeight35.h,
        itemHeight: kDefaultButtonHeight35.h,
        dropdownDecoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(defaultBorderRadius.r),
          // border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        ),
      ),
    );
  }

  Padding buildHistoryView(HistoryController controller) {
    return Padding(
      padding: const EdgeInsets.all(
        kDefaultPaddingScreen,
      ),
      child: Obx(
        () => PullToRefreshList(
          docs: controller.listHistory.value.docs,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          refreshController: controller.refreshController,
          callback: () {
            controller.onRefresh();
          },
          isLoading: controller.isLoading.value,
        ),
      ),
    );
  }
}
