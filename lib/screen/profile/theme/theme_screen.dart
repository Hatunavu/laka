import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/screen/profile/theme/theme_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController controller = Get.put(ThemeController());
    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      title: 'appUI'.tr,
      leading: IconButton(
        onPressed: () => context.router.pop(),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(kDefaultPaddingScreen.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 5,
              child: GestureDetector(
                onTap: () async {
                  if (controller.themeType.value != ThemeTypeEnum.colorful) {
                    ThemeServices().switchTheme();
                    controller.themeType.value = ThemeTypeEnum.colorful;
                  }
                  //Change to Red Icon
                  try {
                    if (await FlutterDynamicIcon.supportsAlternateIcons) {
                      await FlutterDynamicIcon.setAlternateIconName("red");
                      return;
                    }
                  } on PlatformException {
                  } catch (e) {}
                },
                child: SizedBox(
                  child: Column(
                    children: [
                      Image.asset('assets/images/theme/Colorful.png'),
                      Text(
                        'colorful'.tr,
                        style: AppTextStyle().titleRegular16,
                      ),
                      Radio<ThemeTypeEnum>(
                        activeColor: Theme.of(context).primaryColor,
                        value: ThemeTypeEnum.colorful,
                        groupValue: controller.themeType.value,
                        onChanged: (ThemeTypeEnum? value) async {
                          if (controller.themeType.value != value) {
                            ThemeServices().switchTheme();
                            controller.themeType.value =
                                value ?? ThemeTypeEnum.colorful;
                          }
                          //Change to Red Icon
                          try {
                            if (await FlutterDynamicIcon
                                .supportsAlternateIcons) {
                              await FlutterDynamicIcon.setAlternateIconName(
                                  "red");
                              // ignore: avoid_print
                              print("App icon change successful");
                              return;
                            }
                          } on PlatformException {
                          } catch (e) {}
                          // ignore: avoid_print
                          print("Failed to change app icon");
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: () async {
                    if (controller.themeType.value != ThemeTypeEnum.luxury) {
                      ThemeServices().switchTheme();
                      controller.themeType.value = ThemeTypeEnum.luxury;
                    }
                    //Change to Red Icon
                    try {
                      if (await FlutterDynamicIcon.supportsAlternateIcons) {
                        await FlutterDynamicIcon.setAlternateIconName("black");
                        print("App icon change successful");
                        return;
                      }
                    } on PlatformException {
                    } catch (e) {}
                    print("Failed to change app icon");
                  },
                  child: SizedBox(
                    child: Column(
                      children: [
                        Image.asset('assets/images/theme/Luxury.png'),
                        Text(
                          'luxury'.tr,
                          style: AppTextStyle().titleRegular16,
                        ),
                        Radio<ThemeTypeEnum>(
                          activeColor: Theme.of(context).primaryColor,
                          value: ThemeTypeEnum.luxury,
                          groupValue: controller.themeType.value,
                          onChanged: (ThemeTypeEnum? value) async {
                            if (controller.themeType.value != value) {
                              ThemeServices().switchTheme();
                              controller.themeType.value =
                                  value ?? ThemeTypeEnum.luxury;
                            }
                            //Change to Red Icon
                            try {
                              if (await FlutterDynamicIcon
                                  .supportsAlternateIcons) {
                                await FlutterDynamicIcon.setAlternateIconName(
                                    "black");
                                print("App icon change successful");
                                return;
                              }
                            } on PlatformException {
                            } catch (e) {}
                            print("Failed to change app icon");
                          },
                        )
                      ],
                    ),
                  ),
                )),
            // Text(
            //   'Colorful'.tr,
            //   style: AppTextStyle().titleRegular16,
            // ),
            // CupertinoSwitch(
            //   activeColor: Theme.of(context).primaryColor,
            //   trackColor: Theme.of(context).primaryColor,
            //   value: ThemeServices().isDarkMode,
            //   onChanged: (value) {
            //     ThemeServices().switchTheme();
            //   },
            // ),
            // Text(
            //   'Luxury'.tr,
            //   style: AppTextStyle().titleRegular16,
            // ),
          ],
        ),
      ),
    );
  }
}
