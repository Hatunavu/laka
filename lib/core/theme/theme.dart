import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

enum ThemeTypeEnum { luxury, colorful }

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    backgroundColor: kColorBackgroundLight,
    primaryColor: kColorPrimaryLight,
    brightness: Brightness.light,
    scaffoldBackgroundColor: kColorBackgroundLight,
    appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: kColorBackgroundLight),
    iconTheme: const IconThemeData(color: kColorBackgroundDark),
    textTheme: ThemeData.dark()
        .textTheme
        .apply(bodyColor: kColorTextLight, fontFamily: "Poppins"),
    colorScheme: const ColorScheme.light(
      primary: kColorPrimaryLight,
      secondary: kColorSecondaryLight,
      secondaryVariant: kColorGreyLight,
      error: errorColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kColorBackgroundLight,
      unselectedItemColor: kColorSecondaryLight,
      selectedIconTheme: IconThemeData(color: kColorPrimaryLight),
      showUnselectedLabels: true,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade300,
      disabledColor: Colors.grey.shade200,
      selectedColor: kColorPrimaryLight,
      secondarySelectedColor: kColorPrimaryLight.withOpacity(0.4),
      // elevation: 2,
      pressElevation: 0,
      padding: const EdgeInsets.all(4.0),
      labelStyle: AppTextStyle().subtitleRegular14,
      secondaryLabelStyle:
          AppTextStyle().subtitleRegular14.copyWith(color: kColorPrimaryLight),
      brightness: Brightness.light,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    backgroundColor: kColorBackgroundDark,
    primaryColor: kColorPrimaryDark,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kColorBackgroundDark,
    appBarTheme: const AppBarTheme(
        centerTitle: false, elevation: 0, backgroundColor: Colors.black),
    iconTheme: const IconThemeData(color: kColorPrimaryDark),
    textTheme: ThemeData.dark()
        .textTheme
        .apply(bodyColor: kColorTextDark, fontFamily: "Poppins"),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kColorPrimaryDark,
      secondary: kColorSecondaryDark,
      secondaryVariant: kColorGreyDark,
      error: errorColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kColorBackgroundDark,
      unselectedItemColor: kColorSecondaryDark,
      selectedIconTheme: IconThemeData(color: kColorPrimaryDark),
      showUnselectedLabels: true,
    ),
    // chipTheme: ChipThemeData(
    //   backgroundColor: chipBackgroundClr,
    //   disabledColor: chipDisableClr,
    //   selectedColor: chipSelectedClr,
    //   secondarySelectedColor: chipSelectedClr,
    //   elevation: 2,
    //   pressElevation: 8,
    //   padding: const EdgeInsets.all(4.0),
    //   labelStyle: subTitleStyle,
    //   secondaryLabelStyle: subTitleStyle,
    //   brightness: Brightness.dark,
    // ),
  );
}

const appBarTheme = AppBarTheme(centerTitle: true, elevation: 0);

ButtonStyle get outlinedRoundedStyle {
  return OutlinedButton.styleFrom(
    primary: Get.isDarkMode ? kColorTextDark : kColorTextLight,
    shape: const StadiumBorder(),
    textStyle: subTitleStyle,
    backgroundColor: Colors.white,
    side: const BorderSide(color: kColorPrimaryLight, width: 2),
  );
}

ButtonStyle get roundedButtonStyle {
  return ElevatedButton.styleFrom(
    elevation: 0,
    primary:
        ThemeServices().isDarkMode ? kColorPrimaryDark : kColorPrimaryLight,
    shape: const StadiumBorder(),
  );
}

TextStyle get appBarTitleStyle {
  return TextStyle(
      color: ThemeServices().isDarkMode ? Colors.black : Colors.white);
}

Color get appBarTitleColor {
  return ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight;
}

TextStyle get subHeadingStyle {
  return TextStyle(
      fontSize: 22.sp, fontWeight: FontWeight.w400, color: Colors.grey);
}

TextStyle get headingStyle {
  return TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold);
}

TextStyle get detailHeadingStyle {
  return TextStyle(
      fontSize: 32.sp, fontWeight: FontWeight.normal, color: Colors.white);
}

TextStyle get detailSubHeadingStyle {
  return TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.white);
}

TextStyle get titleStyle {
  return TextStyle(
      fontSize: 15.sp,
      color: ThemeServices().isDarkMode ? kColorGreyDark : Colors.black87,
      fontWeight: FontWeight.w500);
}

TextStyle get subTitleStyle {
  return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
}

TextStyle get subTitleSecondaryStyle {
  return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
}

TextStyle get priceTitleStyle {
  return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Get.isDarkMode ? Colors.grey[600] : Colors.black);
}

TextStyle get categoryTitleStyle {
  return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[600] : Colors.black);
}

TextStyle get titleComponentStyle {
  return TextStyle(
      fontSize: 16.sp, color: Get.isDarkMode ? Colors.grey[600] : Colors.black);
}

TextStyle get chipSelectedStyle {
  return TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.white);
}

TextStyle get vendorTitleStyle {
  return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[600] : Colors.black);
}

TextStyle get titleAuthScreen {
  return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 32.sp,
      color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
}

TextStyle get subTitleAuthScreen {
  return TextStyle(
      fontSize: 14.sp,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600]);
}

TextStyle get actionTitleAuth {
  return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.grey[400] : HexColor(textColor));
}

TextStyle get searchScreenTitle {
  return TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: ThemeServices().isDarkMode ? kColorGreyDark : Colors.grey[600]);
}

TextStyle get titleStylePrimaryColor {
  return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.grey[400] : HexColor(secondaryColorLight));
}

TextStyle get bookContentStyle {
  return TextStyle(
      fontSize: 14.sp,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600]);
}

TextStyle get messageTitle {
  return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.white);
}

TextStyle get notificationTitle {
  return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.black);
}

Paint paint = Paint()
  ..color = kColorPrimaryLight
  ..style = PaintingStyle.stroke
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..strokeWidth = 2.0;

BoxDecoration calendarDecoration = const BoxDecoration(
  color: Colors.transparent,
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
);
