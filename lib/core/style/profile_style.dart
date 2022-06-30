import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle get accountHeadTitleStyle {
  return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.black);
}
