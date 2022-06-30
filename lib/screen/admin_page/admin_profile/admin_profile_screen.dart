import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/profile_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/admin_page/admin_main/admin_main_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AdminProfileScreen extends StatefulWidget {
  AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Container(
          alignment: Alignment.center, child: profileScreenDetail(context)),
    );
  }

  Widget profileScreenDetail(BuildContext context) {
    final AdminMainController mainController = Get.find();
    final myProfile = mainController.account.value;

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
              height: kDefaultPaddingWidget.h * 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
              child: Column(
                children: [
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
}
