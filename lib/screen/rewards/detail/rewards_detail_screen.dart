import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/rewards/reward_data.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/rewards/detail/rewards_detail_controller.dart';
import 'package:client_tggt/screen/rewards/rewards_guide/rewards_guilde_controller.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/progress_bar.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class RewardsDetailScreen extends StatelessWidget {
  const RewardsDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RewardsDetailController controller =
        Get.put(RewardsDetailController(getIt.get<ApiClient>()));
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ThemeServices().isDarkMode
                    ? AppPath.rewardsBackgroundDark
                    : AppPath.rewardsBackgroundLight),
                fit: BoxFit.contain)),
        child: SafeArea(
          child: Column(
            children: [
              renderHeader(context, controller),
              Obx(() => renderLakaPoint(context, controller)),
              renderListAction(context, controller)
            ],
          ),
        ),
      ),
    );
  }

  Widget renderHeader(
      BuildContext context, RewardsDetailController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: 50.w,
            margin: EdgeInsets.only(bottom: 5.h),
            child: InkWell(
              onTap: () async {
                context.router.pop();
              },
              child: Icon(
                Ionicons.chevron_back_outline,
                size: 25.sp,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.zero,
            child: Text(
              "Laka point",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          Container(
            width: 50.w,
          )
        ],
      ),
    );
  }

  Widget renderLakaPoint(
      BuildContext context, RewardsDetailController controller) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ThemeServices().isDarkMode
                  ? AppPath.rewardsMedalDarkGold
                  : AppPath.rewardsMedalLightGold),
              fit: BoxFit.contain)),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '${controller.rewardsData.value.currentPoints ?? 0}',
          style: TextStyle(
              fontSize: 38.sp,
              fontWeight: FontWeight.bold,
              color: ThemeServices().isDarkMode
                  ? const Color(0xFF1F313E)
                  : kColorPrimaryLight),
          children: <TextSpan>[
            const TextSpan(text: '\n'),
            TextSpan(
                text: 'Laka point',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                    color: ThemeServices().isDarkMode
                        ? const Color(0xFF1F313E)
                        : kColorPrimaryLight)),
          ],
        ),
      ),
    );
  }

  Widget renderListAction(
      BuildContext context, RewardsDetailController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPaddingWidget.h,
          horizontal: kDefaultPaddingScreen.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'congratulation'.tr,
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              children: <TextSpan>[
                const TextSpan(text: '\n'),
                TextSpan(
                    text: controller.rewardsData.value.currentTier ==
                            TierType.none
                        ? "${'youAre'.tr} ${controller.rewardsData.value.currentTier.display()}"
                        : '${'youAre2'.tr} ${controller.rewardsData.value.currentTier.display()}',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white)),
              ],
            ),
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h * 2.5,
          ),
          actionItem(context, 'membershipBenefits'.tr, () {
            context.router.push(const TierBenefitsPage());
          }),
          SizedBox(
            height: kDefaultPaddingItem.h + 3.h,
          ),
          actionItem(context, 'pointHistory'.tr, () {
            context.router
                .push(const RewardsHistoryPage())
                .then((value) => Get.delete<RewardsDetailController>());
          }),
          SizedBox(
            height: kDefaultPaddingItem.h + 3.h,
          ),
          actionItem(context, "pointGuide".tr, () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text("notification".tr),
                      content: Text("featureDeveloping".tr),
                      actions: [
                        CupertinoDialogAction(
                            child: Text("confirm".tr),
                            onPressed: () {
                              context.router.pop();
                            })
                      ],
                    ));
          })
        ],
      ),
    );
  }

  Widget actionItem(BuildContext context, String title, Function() onPress) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
      child: GestureDetector(
        onTap: onPress,
        child: Center(
            child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPaddingWidget.w,
                  vertical: kDefaultPaddingWidget.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius.r),
                  color: Colors.grey.shade200.withOpacity(0.3)),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp),
              ),
            ),
          ),
        )),
      ),
    );
  }

  Column buildTotalPoint(
      BuildContext context, RewardsDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'youHave'.tr,
          style: AppTextStyle().subtitleRegular14Grey,
        ),
        SizedBox(height: kDefaultPaddingItem.h),
        Obx(
          () => RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: '${controller.rewardsData.value.currentPoints ?? 0}',
                  style: AppTextStyle()
                      .heading1Regular24
                      .copyWith(color: Theme.of(context).primaryColor)),
              WidgetSpan(child: SizedBox(width: 6.w)),
              TextSpan(
                text: 'Laka Point',
                style: AppTextStyle().subtitleRegular14Grey,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Container buildPointExpireDate() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
            color:
                ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding.w, vertical: kDefaultPaddingItem.h),
        child: AutoSizeText(
          'pointOutDate'.tr,
          style: AppTextStyle().eyebrowRegular10Grey,
          maxLines: 1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildPointHistory(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router
            .push(const RewardsHistoryPage())
            .then((value) => Get.delete<RewardsDetailController>());
      },
      child: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'pointHistory'.tr,
                  style:
                      AppTextStyle().subtitleRegular14.copyWith(height: 1.2.h),
                ),
                Icon(
                  Ionicons.chevron_forward_outline,
                  size: 15.sp,
                  color: Theme.of(context).iconTheme.color,
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget buildPointGuide(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router
            .push(const RewardsGuidePage())
            .then((value) => Get.delete<RewardsGuideController>());
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'pointGuide'.tr,
                style: AppTextStyle().subtitleRegular14.copyWith(height: 1.2.h),
              ),
              Icon(
                Ionicons.chevron_forward_outline,
                size: 15.sp,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  SliverAppBar buildHeader(BuildContext context,
      RewardsDetailController controller, MainController mainController) {
    return SliverAppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).primaryColor,
      pinned: true,
      title: Text('Laka Point',
          style: TextStyle(color: Theme.of(context).backgroundColor)),
      leading: IconButton(
        onPressed: () {
          Get.delete<RewardsDetailController>();
          context.router.pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      expandedHeight: 200.h,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          Positioned(
            left: kDefaultPadding.w,
            right: kDefaultPadding.w,
            bottom: -30.h,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/membership/Member-card 1.png',
                ),
                Positioned(
                  left: kDefaultPadding.w,
                  right: kDefaultPadding.w,
                  top: 24.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                          mainController.account.value.profile?.fullName ?? '',
                          style: AppTextStyle()
                              .subtitleBold14
                              .copyWith(color: kColorTextLight))),
                      SizedBox(height: 3.h),
                      Obx(() => Text(
                          controller.rewardsData.value.currentTier.display(),
                          style: AppTextStyle()
                              .subtitleRegular14
                              .copyWith(color: kColorTextLight))),
                      SizedBox(height: 24.h),
                      SizedBox(
                        height: 3.h,
                        child: Obx(
                          () => ProgressBar(
                            max: controller.nextTierPoint.value,
                            current: controller.currentPoint.value,
                            backgroundColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Obx(
                        () => controller.checkIsMaxTier()
                            ? const SizedBox.shrink()
                            : Text(
                                '${'pointsNeedToReach'.tr} ${controller.rewardsData.value.nextTier.display()}: ${controller.rewardsData.value.pointsToLevelUp}',
                                style: AppTextStyle().eyebrowRegular10Grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: kDefaultPadding.w,
            right: kDefaultPadding.w,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                context.router.push(const TierBenefitsPage());
              },
              child: Container(
                color: Colors.black12,
                height: 30.h,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: (kDefaultPadding + 4).w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'membershipBenefits'.tr,
                        style: AppTextStyle().eyebrowRegular10.copyWith(
                              height: 1.2.h,
                              color: kColorTextLight,
                            ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: kColorTextLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
