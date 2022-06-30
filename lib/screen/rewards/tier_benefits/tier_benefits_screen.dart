import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/rewards/reward_data.dart';
import 'package:client_tggt/screen/rewards/rewards_controller.dart';
import 'package:client_tggt/screen/rewards/tier_benefits/tier_benefits_controller.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/progress_bar.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TierBenefitsScreen extends StatelessWidget {
  const TierBenefitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RewardsController controller =
        Get.put(RewardsController(getIt.get<ApiClient>()));
    inspect(controller.rewardsData.value);
    return Obx(() => BaseScreen(
          title: 'reward'.tr,
          backgroundColor: Theme.of(context).backgroundColor,
          leading: IconButton(
            onPressed: () {
              Get.delete<TierBenefitsController>();
              context.router.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ThemeServices().isDarkMode
                  ? Theme.of(context).primaryColor
                  : kColorBackgroundDark,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'youAre2'.tr +
                      ' ${controller.rewardsData.value.currentTier.getType() == 0 ? "" : controller.rewardsData.value.currentTier.display().toLowerCase()}',
                  style: AppTextStyle().titleSemi16.copyWith(
                      height: 1.2, color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                AutoSizeText.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: 'youNeed'.tr +
                            ' ${controller.rewardsData.value.nextTierPoints} ' +
                            'toUp'.tr,
                        style: const TextStyle(height: 1.2)),
                    TextSpan(
                        text:
                            ' ${controller.rewardsData.value.nextTier.display()}',
                        style: const TextStyle(
                            height: 1.2, fontWeight: FontWeight.w600)),
                  ]),
                ),
                SizedBox(height: kDefaultPadding.h),
                ProgressBar(
                  max: controller.nextTierPoint.value,
                  current: controller.currentPoint.value,
                  backgroundColor: Colors.black12,
                ),
                SizedBox(height: 8.h),
                AutoSizeText.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                          text: '${controller.rewardsData.value.currentPoints}',
                        ),
                        const TextSpan(
                          text: '/',
                        ),
                        TextSpan(
                          text:
                              '${controller.rewardsData.value.nextTierPoints}',
                        ),
                        TextSpan(
                          text: ' ' + 'point'.tr,
                        ),
                      ],
                      style: TextStyle(
                          color: ThemeServices().isDarkMode
                              ? kColorGreyDark
                              : kColorGreyLight)),
                ),
                SizedBox(height: kDefaultPadding.h),
                DefaultTabController(
                  length: 4,
                  child: SizedBox(
                    height: 500.0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelColor: Theme.of(context).primaryColor,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.secondary,
                          indicatorColor: Theme.of(context).primaryColor,
                          tabs: [
                            Tab(text: 'silverTier'.tr),
                            Tab(text: 'goldTier'.tr),
                            Tab(text: 'diamondTier'.tr),
                            Tab(text: 'blackDiamondTier'.tr),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.all(kDefaultPaddingScreen),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BenefitWidget(
                                        onTap: () {}, content: 'discount10'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'freeTea'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'upFree'.tr),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(kDefaultPaddingScreen),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BenefitWidget(
                                        onTap: () {}, content: 'discount10'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'freeTea'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'upFree'.tr),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(kDefaultPaddingScreen),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BenefitWidget(
                                        onTap: () {}, content: 'discount10'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'freeTea'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'upFree'.tr),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.all(kDefaultPaddingScreen),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BenefitWidget(
                                        onTap: () {}, content: 'discount10'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'freeTea'.tr),
                                    BenefitWidget(
                                        onTap: () {}, content: 'upFree'.tr),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class BenefitWidget extends StatelessWidget {
  const BenefitWidget({
    Key? key,
    required this.onTap,
    required this.content,
  }) : super(key: key);

  final Function() onTap;
  final String content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: kDefaultPaddingItem.h / 2),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/star-bullet.svg'),
            SizedBox(width: kDefaultPaddingWidget.w),
            AutoSizeText(
              content,
              style: TextStyle(
                  height: 1.2,
                  fontSize: 13.sp,
                  color: ThemeServices().isDarkMode
                      ? kColorGreyDark
                      : Colors.black87),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorGreyDark
                        : kColorGreyLight,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
