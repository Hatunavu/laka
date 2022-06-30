import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle get searchRecentTitle {
  return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.black);
}

TextStyle get searchRecentSubTitle {
  return TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600]);
}
