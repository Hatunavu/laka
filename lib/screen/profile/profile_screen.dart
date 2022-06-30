import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/profile/affiliate/affiliate_controller.dart';
import 'package:client_tggt/screen/profile/language/language_controller.dart';
import 'package:client_tggt/screen/profile/newfeed/user_newfeed_controller.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/screen/profile/theme/theme_controller.dart';
import 'package:client_tggt/screen/profile/widget/profile_shimmer.dart';
import 'package:client_tggt/screen/rewards/detail/rewards_detail_controller.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_controller.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/not_login_screen.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController mainController =
        Get.put(MainController(getIt.get<ApiClient>()));
    final ProfileController controller =
        Get.put(ProfileController(getIt.get<ApiClient>()));
    controller.getMe();
    return mainController.userToken.value == ""
        ? NotLoginScreen(
            title: "loginToSeeProfileTitle".tr,
            subTitle: "loginToSeeProfileLabel".tr)
        : BaseScreen(
            backgroundColor: Theme.of(context).backgroundColor,
            // title: "account".tr,
            child: Obx(
              () => Container(
                  child: controller.isLoading.value == true
                      ? const ProfileShimmer()
                      : profileScreenDetail(context, controller)),
            ));
  }
}

Widget profileScreenDetail(BuildContext context, ProfileController controller) {
  final MainController mainController =
      Get.put(MainController(getIt.get<ApiClient>()));
  final myProfile = controller.account.value;
  // print("status : ${myProfile.pendingVendorApplications}");
  return Container(
    padding: EdgeInsets.all(kDefaultPaddingWidget.w),
    margin: EdgeInsets.only(
        bottom: kDefaultPaddingWidget.h, top: kDefaultPaddingWidget.h),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            showCupertinoModalPopup<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  return CupertinoActionSheet(
                    title: Text('action'.tr),
                    // message: const Text('Message'),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        child: Text('camera'.tr),
                        onPressed: () {
                          controller.handlePickImage(ImageSource.camera);
                          context.router.pop();
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text('photoLibrary'.tr),
                        onPressed: () {
                          controller.handlePickImage(ImageSource.gallery);
                          context.router.pop();
                        },
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => context.router.pop(),
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Container(
            padding: EdgeInsets.zero,
            child: controller.isLoadingUpdateImage.value == true
                ? const Text("updating...")
                : CachedNetworkImage(
                    imageUrl: controller.avatarAccount.value.path ??
                        "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png",
                    memCacheHeight: 200,
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 70,
                    ),
                  ),
          ),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        Text(myProfile.profile?.fullName ?? "",
            style: AppTextStyle().heading1Semi24),
        const SizedBox(
          height: 16,
        ),
        Text(
          '${myProfile.phone}',
          style: AppTextStyle().subtitleRegular14Grey,
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h * 2,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
              child: Column(
                children: [
                  profileSettingItem(context, "accountManagement".tr,
                      Ionicons.person_circle_outline, 0, () {
                    context.router.push(const ProfileInformationPage());
                  }),
                  profileSettingItem(
                      context, "shareLaka".tr, Ionicons.share_social_outline, 1,
                      () {
                    context.router
                        .push(AffiliatePage(account: controller.account.value))
                        .then((value) => {Get.delete<AffiliateController>()});
                  }),
                  profileSettingItem(context, "Laka Point".tr, Ionicons.gift, 2,
                      () {
                    context.router.push(const RewardsDetailPage()).then(
                        (value) => {Get.delete<RewardsDetailController>()});
                  }),
                  profileSettingItem(
                      context, 'Bài đăng của tôi', Ionicons.heart_outline, 3,
                      () {
                    context.router.push(const UserNewfeedPage()).then((value) {
                      Get.delete<UserNewfeedController>();
                    });
                  }),
                  profileSettingItem(
                      context, "language".tr, Ionicons.globe_outline, 4, () {
                    context.router
                        .push(const LanguagePage())
                        .then((value) => {Get.delete<LanguageController>()});
                  }),
                  profileSettingItem(context, "helpAndSupport".tr,
                      Ionicons.help_circle_outline, 3, () {
                    context.router.push(HelpAndSupportPage());
                  }),
                  profileSettingItem(
                      context, "termsOfService".tr, Ionicons.receipt_outline, 3,
                      () {
                    context.router.push(const TermOfServicePage());
                  }),
                  profileSettingItem(
                      context, "appUI".tr, CupertinoIcons.paintbrush, 4, () {
                    context.router
                        .push(const ThemePage())
                        .then((value) => Get.delete<ThemeController>());
                  }),
                  profileSettingItem(
                      context,
                      controller.account.value.vendor != null
                          ? "vendor".tr
                          : "createVendor".tr,
                      Ionicons.wallet_outline,
                      4, () {
                    if (controller.account.value.vendor == null) {
                      if (controller.account.value.pendingVendorApplications ==
                          1) {
                        context.router.push(const SignupVendorSuccessPage());
                      } else {
                        context.router
                            .push(SignUpVendorFirstPage(
                                account: controller.account.value))
                            .then((value) =>
                                Get.delete<CreateVendorController>());
                      }
                    } else {
                      Get.delete<MainController>();
                      Get.delete<HomeController>();
                      Get.delete<ProfileController>();
                      Get.delete<NewfeedController>();
                      Get.delete<ActivityController>();

                      Get.delete<VendorMainController>();
                      Get.delete<VendorProductController>();
                      Get.delete<VendorBookingController>();
                      Get.delete<VendorProfileController>();
                      AccountServices().saveLanguageCode("vi");
                      AccountServices()
                          .saveAccountType(AccountType.vendor.display());
                      if (ThemeServices().isDarkMode) {
                        ThemeServices().switchTheme();
                      }
                      context.router.popUntilRoot();
                      context.router.push(const VendorMainPage());
                    }
                  }),
                  profileSettingItem(
                      context, "logOut".tr, Ionicons.log_out_outline, 5, () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return CustomCupertinoAlert(
                          context: context,
                          title: "logOut".tr,
                          content: 'confirmLogout'.tr,
                          rightButtonTitle: 'confirm'.tr,
                          rightAction: () async {
                            Navigator.pop(context);
                            // await Get.delete<HomeController>();
                            await mainController.handleLogoutAccount();
                            context.router
                                .replace(SplashPage(isFristLoad: false));
                            getIt.get<IToast>().show(
                                title: 'logOutSuccess'.tr,
                                message: 'logOutSuccess'.tr,
                                hasDismissButton: false,
                                duration: const Duration(milliseconds: 1000));
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget profileSettingItem(BuildContext context, String title, IconData icon,
    int index, Function()? onTap) {
  return Container(
    margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h * 1.5),
    child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              width: kDefaultPaddingWidget.w * 2,
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 8.h),
                    child: Text(
                      title,
                      style: AppTextStyle().titleRegular16,
                    )))
          ],
        )),
  );
}
