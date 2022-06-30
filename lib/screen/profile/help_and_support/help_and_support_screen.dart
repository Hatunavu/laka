import 'dart:ui';

import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({Key? key}) : super(key: key);

  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeServices().isDarkMode
          ? kColorBackgroundDark
          : kColorPrimaryLight,
      body: SafeArea(
          bottom: false,
          child: Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: ThemeServices().isDarkMode
                      ? kColorBackgroundDark
                      : kColorPrimaryLight),
              child: Column(children: [
                renderHeader(context),
                Expanded(
                    flex: 6,
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingWidget.w,
                            vertical: kDefaultPaddingItem.h),
                        child: Center(
                            child: ClipRect(
                                child: ClipRect(
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: kDefaultPaddingWidget.h,
                                              horizontal:
                                                  kDefaultPaddingWidget.w * 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultBorderRadius.r),
                                              color: Colors.grey.shade200
                                                  .withOpacity(0.2)),
                                          child: Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              renderButtonSupport(
                                                  context,
                                                  Ionicons.call_outline,
                                                  "Hotline: 0832909909",
                                                  () async {
                                                String telephoneNumber =
                                                    "0832909909";
                                                String telephoneUrl =
                                                    "tel:$telephoneNumber";
                                                if (await canLaunch(
                                                    telephoneUrl)) {
                                                  await launch(telephoneUrl);
                                                } else {
                                                  throw "Error occured trying to call that number.";
                                                }
                                              }),
                                              renderButtonSupport(
                                                  context,
                                                  Ionicons.mail_unread_outline,
                                                  "lienhe@laka.com.vn",
                                                  () async {
                                                const url =
                                                    'mailto:lienhe@laka.com.vn';
                                                if (await canLaunch(url)) {
                                                  await launch(url);
                                                } else {
                                                  throw 'Could not launch $url';
                                                }
                                              }),
                                              renderButtonSupport(
                                                  context,
                                                  Ionicons.logo_facebook,
                                                  "LAKA fanpage", () async {
                                                String fbProtocolUrl;
                                                if (GetPlatform.isIOS) {
                                                  fbProtocolUrl =
                                                      'fb://profile/622802141092136';
                                                } else {
                                                  fbProtocolUrl =
                                                      'fb://page/622802141092136';
                                                }

                                                String fallbackUrl =
                                                    'https://www.facebook.com/LAKAthegioigiaitri';

                                                try {
                                                  bool launched = await launch(
                                                      fbProtocolUrl,
                                                      forceSafariVC: false);

                                                  if (!launched) {
                                                    await launch(fallbackUrl,
                                                        forceSafariVC: false);
                                                  }
                                                } catch (e) {
                                                  await launch(fallbackUrl,
                                                      forceSafariVC: false);
                                                }
                                              })
                                            ],
                                          )),
                                        ))))))),
                Expanded(
                    flex: 4,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ThemeServices().isDarkMode
                                    ? AppPath.affiliateDark
                                    : AppPath.affiliateLight),
                                fit: BoxFit.cover)))),
              ]))),
    );
  }

  Widget renderHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 3.h),
            child: IconButton(
                onPressed: () {
                  context.router.pop();
                },
                icon: Icon(
                  Ionicons.chevron_back_outline,
                  size: 22.sp,
                  color: Colors.white,
                )),
          ),
          Text("helpAndSupport".tr,
              style: titleStyle.copyWith(color: Colors.white)),
          Container(
            width: 100.w,
          )
        ],
      ),
    );
  }

  Widget renderButtonSupport(
      BuildContext context, IconData icon, String title, Function() onback) {
    return InkWell(
      onTap: onback,
      child: Container(
        padding: EdgeInsets.zero,
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 1.w,
                color: Colors.white,
              )),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30.sp,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.h),
                  child: Text(
                    title,
                    style: titleStyle.copyWith(color: Colors.white),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
