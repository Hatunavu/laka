import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/profile_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/screen/profile/widget/profile_shimmer.dart';
import 'package:client_tggt/screen/splash/splash_creen.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:client_tggt/screen/vendors/product/vendor_product_controller.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_profile_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VendorProfileScreen extends StatelessWidget {
  const VendorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorProfileController controller =
        Get.put(VendorProfileController(getIt.get<ApiClient>()));
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Hồ sơ",
        child: Obx(
          () => Container(
              child: controller.isLoading.isTrue
                  ? const ProfileShimmer()
                  : profileScreenDetail(context, controller)),
        ));
  }
}

Widget profileScreenDetail(
    BuildContext context, VendorProfileController controller) {
  final VendorMainController mainController =
      Get.put(VendorMainController(getIt.get<ApiClient>()));
  final myProfile = controller.account.value;

  return Container(
    padding: EdgeInsets.all(kDefaultPaddingWidget.h),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          myProfile.profile != null
              ? CachedNetworkImage(
                  // imageUrl: '${myProfile.profile?.avatar?.path}',
                  imageUrl: myProfile.getVendorThumnail == ""
                      ? myProfile.accountAvatar
                      : myProfile.getVendorThumnail ?? "",
                  memCacheHeight: 200,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.4),
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 70,
                  ),
                )
              : Container(),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          myProfile.profile != null
              ? Text(myProfile.vendorBrandname ?? "",
                  style: accountHeadTitleStyle)
              : const Text(""),
          SizedBox(
            height: kDefaultPaddingItem.h,
          ),
          Text(
            '${myProfile.phone}',
            style: subTitleStyle,
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h * 2,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
            child: Column(
              children: [
                profileSettingItem(
                    context, "Thông tin tài khoản", Ionicons.person_outline, 0,
                    () {
                  context.router.push(const VendorProfileInformationPage());
                }),
                profileSettingItem(
                    context, "Quản lý đánh giá", Ionicons.reader_outline, 1,
                    () {
                  context.router.push(const VendorsReviewsPage());
                }),
                profileSettingItem(context, "Quản lý kỹ thuật viên",
                    Ionicons.reader_outline, 1, () {
                  context.router.push(const WaitressManagerPage());
                }),
                profileSettingItem(
                    context, "Quản lý Menu", Ionicons.menu_outline, 1, () {
                  context.router.push(ListMenuPage());
                }),
                profileSettingItem(context, "Thông tin xác minh",
                    Ionicons.checkmark_circle_outline, 1, () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: const Text("Thông báo"),
                            content:
                                const Text("Tính năng đang được phát triển"),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Xác nhận"),
                                  onPressed: () {
                                    context.router.pop();
                                  })
                            ],
                          ));
                }),
                profileSettingItem(
                    context, "Thông tin thanh toán", Ionicons.card_outline, 2,
                    () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: const Text("Thông báo"),
                            content:
                                const Text("Tính năng đang được phát triển"),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Xác nhận"),
                                  onPressed: () {
                                    context.router.pop();
                                  })
                            ],
                          ));
                }),
                profileSettingItem(context, "Trung tâm hỗ trợ",
                    Ionicons.help_circle_outline, 3, () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                            title: const Text("Thông báo"),
                            content:
                                const Text("Tính năng đang được phát triển"),
                            actions: [
                              CupertinoDialogAction(
                                  child: const Text("Xác nhận"),
                                  onPressed: () {
                                    context.router.pop();
                                  })
                            ],
                          ));
                }),
                profileSettingItem(
                    context, "Trang khách hàng", Ionicons.wallet_outline, 4,
                    () {
                  Get.delete<VendorMainController>();
                  Get.delete<VendorProductController>();
                  Get.delete<VendorBookingController>();
                  Get.delete<VendorProfileController>();
                  Get.delete<MainController>();
                  Get.delete<HomeController>();
                  Get.delete<ProfileController>();
                  Get.delete<NewfeedController>();
                  Get.delete<ActivityController>();

                  AccountServices()
                      .saveAccountType(AccountType.customer.getType());

                  context.router.popUntilRoot();
                  context.router.push(SplashPage(isFristLoad: false));
                }),
                profileSettingItem(context, "logOut".tr, Ionicons.log_out, 4,
                    () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return CustomCupertinoAlert(
                        context: context,
                        title: 'logOut'.tr,
                        content: 'confirmLogout'.tr,
                        rightButtonTitle: 'confirm'.tr,
                        rightAction: () async {
                          Navigator.pop(context);
                          await mainController.handleLogoutAccount();
                          context.router
                              .replace(SplashPage(isFristLoad: false));
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          )
        ],
      ),
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
            Container(
              margin: EdgeInsets.only(bottom: 4.h),
              child: Icon(
                icon,
                size: 26,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              width: kDefaultPaddingWidget.h * 2,
            ),
            Expanded(
                child: Text(
              title,
              style: subTitleStyle.copyWith(fontSize: 16),
            ))
          ],
        )),
  );
}
