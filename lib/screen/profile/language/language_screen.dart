import 'package:client_tggt/core/constant/constant.dart';
import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/core/translations/translation_services.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/profile/language/language_controller.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/service_item_attribute_screen.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageController controller = Get.put(LanguageController());
    return BaseScreen(
      title: 'language'.tr,
      leading: IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: Icon(Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            //renderHeader(context),
            renderSettingLanguage(context, controller)
          ],
        ),
      ),
    );
  }
}

Widget renderHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              context.router.pop();
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 100.w,
              height: 50.h,
              child: const Icon(Ionicons.chevron_back_outline, size: 30),
            )),
        Expanded(
            child: Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.only(top: 3.h, right: 100.w),
          alignment: Alignment.center,
          height: 50.h,
          child: Text(
            'language'.tr,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: appBarTitleColor),
          ),
        ))
      ],
    ),
  );
}

Widget renderSettingLanguage(
    BuildContext context, LanguageController controller) {
  // String _selectedLang = LocalizationService.locale.languageCode;
  var listLanguage = <String>[];
  LocalizationService.langs.forEach((key, value) {
    listLanguage.add(value);
  });

  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingScreen.w, vertical: kDefaultPaddingWidget.h),
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: listLanguage.length,
          itemBuilder: (context, int index) {
            return Obx(() => Column(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.handleUpdateLanguageCode(
                            findLanguageCode(listLanguage[index]));
                        getIt.get<IToast>().show(
                            title: 'changeLanguageSuccess'.tr,
                            message: 'changeLanguageSuccess'.tr,
                            hasDismissButton: false,
                            duration: const Duration(milliseconds: 1000));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                            vertical: defaultPaddingItem.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Flag.fromString(findLocale(listLanguage[index]),
                                    height: 22.h,
                                    width: 40.w,
                                    fit: BoxFit.cover),
                                SizedBox(width: kDefaultPaddingWidget.w),
                                Text(
                                  listLanguage[index],
                                  style: AppTextStyle().titleRegular16,
                                ),
                              ],
                            ),
                            Visibility(
                                visible:
                                    findLanguageCode(listLanguage[index]) ==
                                        controller.languageCode.value,
                                child: Icon(Ionicons.checkmark_circle_outline,
                                    size: 26,
                                    color: Theme.of(context).primaryColor))
                          ],
                        ),
                      ),
                    ),
                    renderLineWidget(context)
                  ],
                ));
          })
    ]),
  );
}

// List<DropdownMenuItem<String>> _buildDropdownMenuItems() {
//   var list = <DropdownMenuItem<String>>[];
//   LocalizationService.langs.forEach((key, value) {
//     list.add(DropdownMenuItem<String>(
//       value: value,
//       child: Text(value),
//     ));
//   });
//   return list;
// }

// List<String> _buildListLanguage() {
//   var list = <String>[];
//   LocalizationService.langs.forEach((key, value) {
//     list.add(value);
//   });
//   return list;
// }

String findLanguageCode(String valueCode) {
  var code = "";
  LocalizationService.langs.forEach((key, value) {
    if (value == valueCode) {
      code = key;
    }
  });
  return code;
}

String findLanguage(String countryCode) {
  var language = "";
  LocalizationService.langs.forEach((key, value) {
    if (countryCode == key) {
      language = value;
    }
  });
  return language;
}

String findLocale(String valueCode) {
  var code = findLanguageCode(valueCode);
  for (var item in LocalizationService.locales) {
    if (item.languageCode == code) {
      return item.countryCode ?? "";
    }
  }
  return "";
}
