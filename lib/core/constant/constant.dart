import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//old theme
const primaryColorLight = "#FFFFFF";
const textColor = "#F0B92B";
const secondaryColorLight = "#1F313E";
const secondaryColor = Color(0xFFFF5A5F);
const bottomTabDefaultLight = "#949AA9";
const greyTextColor = "#535B72";
const greyLightColor = "#D8D8D8";

//new theme
const kColorPrimaryLight = Color(0xFFFF5A5F);
const kColorPrimaryDark = Color(0xFFDCC390);
//const kColorPrimaryDark = Color(0xFF1F313E);

const kColorSecondaryDark = Color(0xFFEFE4D1);
const kColorSecondaryLight = Color(0xFF949AA9);

const kColorBackgroundDark = Color(0xFF1F313E);
const kColorBackgroundLight = Color(0xFFFFFFFF);
const kColorBackgroundColored = Color(0xFFE4E8EE);

const kColorGreyDark = Color(0xFF949AA9);
const kColorGreyLight = Color(0xFF949AA9);
const kColorGreyBackGround = Color(0xFFF8F8F8);

const kColorTextDark = Color(0xFFDCC390);
const kColorTextLight = Color(0xFF1F313E);
const kColorTextGrey = Color(0xFF949AA9);

const kColorActionError = Color(0xFFED1D1D);
const kColorActionAlert = Color(0xFFF59A58);
const kColorActionSuccess = Color(0xFF1CBB50);
const kColorActionConfirm = Color(0xFF4e5ae8);
const kColorActionCheckIn = Color(0xFFB906DF);

const kColorStatusPendingDark = Color(0xFFDCC390);
const kColorStatusPendingLight = Color(0xFF998763);

///20
const kDefaultPadding20 = 20.0;

///16
const kDefaultPadding = 16.0;

///14
const kDefaultPaddingWidget = 14.0;

///10
const kDefaultPaddingScreen = 10.0;

///8
const kDefaultPaddingItem = 8.0;
var defaultBorderRadius = 14.0.r;

const kVendorBackgroundColor = "#ededed";
const kChipPadding = 6.0;
const defaultPaddingItem = 10.0;

///45
const kDefaultButtonHeight = 45.0;

///35
const kDefaultButtonHeight35 = 35.0;

const defaultLat = "21.0208823";
const defaultLng = "105.8499577";

const darkGreyClr = Color(0xFF121212);
const primaryColor = Color(0xFF00BF6D);
const completeColor = Color(0xFF00BF6D);

const contentColorLightTheme = Color(0xFF1D1D35);
const contentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const errorColor = Color(0xFFF03738);

const chipSelectedClr = Color(0xFF2D3F6E);
const disableColor = Colors.black12;
const disableText = Colors.black45;
const chipBackgroundClr = Colors.white;
const bluishClr = Color(0xFF4e5ae8);
const primaryClr = bluishClr;
const pinkClr = Color(0XFFff4667);

const defaultBorderRadiusItem = kDefaultPadding * 1.5;

const kdefaultElevated = 0.5;

const mapAPI = "AIzaSyDoCMsqXybKCacgEAMzghkTz_6Xm2aBJPA";

enum CategoryEnum {
  karaoke,
  restaurant,
  massage,
  bar,
}

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      brightness: Brightness.light,
      fontFamily: "Poppins");
  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      brightness: Brightness.dark,
      fontFamily: "Poppins");
}
