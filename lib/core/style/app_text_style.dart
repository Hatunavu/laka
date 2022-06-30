import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static final AppTextStyle _appTextStyle = AppTextStyle._internal();

  factory AppTextStyle() {
    return _appTextStyle;
  }

  AppTextStyle._internal();

  //Special
  TextStyle get specialBold32 {
    return TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get specialBold32Grey {
    return TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get specialSemi32 {
    return TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get specialSemi32Grey {
    return TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get specialRegular32 {
    return TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get specialRegular32Grey {
    return TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }
  //=========================
  //Heading0

  TextStyle get headingBold28 {
    return TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get headingBold28Grey {
    return TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get headingSemi28 {
    return TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get headingSemi28Grey {
    return TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get headingRegular28 {
    return TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get headingRegular28Grey {
    return TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================

  //=========================
  //Heading1

  TextStyle get heading1Bold24 {
    return TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading1Bold24Grey {
    return TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get heading1Semi24 {
    return TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading1Semi24Grey {
    return TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get heading1Regular24 {
    return TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading1Regular24Grey {
    return TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
  //Heading2

  TextStyle get heading2Bold20 {
    return TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading2Bold20Grey {
    return TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get heading2Semi20 {
    return TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading2Semi20Grey {
    return TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get heading2Regular20 {
    return TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading2Regular20Grey {
    return TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
  //Heading3

  TextStyle get heading3Bold18 {
    return TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading3Bold18Grey {
    return TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get heading3Semi18 {
    return TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading3Semi18Grey {
    return TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get heading3Regular18 {
    return TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get heading3Regular18Grey {
    return TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
  //Title

  TextStyle get titleBold16 {
    return TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get titleBold16Grey {
    return TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get titleSemi16 {
    return TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get titleSemi16Grey {
    return TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get titleRegular16 {
    return TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get titleRegular16Grey {
    return TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
  //Subtitle

  TextStyle get subtitleBold14 {
    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get subtitleBold14Grey {
    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get subtitleSemi14 {
    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get subtitleSemi14Grey {
    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get subtitleRegular14 {
    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get subtitleRegular14Grey {
    return TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
  //Paragraph

  TextStyle get paragraphBold12 {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get paragraphBold12Grey {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get paragraphSemi12 {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get paragraphSemi12Grey {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get paragraphRegular12 {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get paragraphRegular12Grey {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
  //Eyebrow

  TextStyle get eyebrowBold10 {
    return TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get eyebrowBold10Grey {
    return TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get eyebrowSemi10 {
    return TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get eyebrowSemi10Grey {
    return TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  TextStyle get eyebrowRegular10 {
    return TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight);
  }

  TextStyle get eyebrowRegular10Grey {
    return TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: ThemeServices().isDarkMode ? kColorGreyDark : kColorGreyLight);
  }

  //=========================
}
