import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/search_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/search_recent_model.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({Key? key, required this.index, required this.item})
      : super(key: key);
  final int index;
  final SearchRecentModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      margin: EdgeInsets.only(top: index > 0 ? kDefaultPaddingItem.h : 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // renderCategoryIcon(context, item.category),
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                image: const DecorationImage(
                    image: AssetImage("assets/images/bar/bar1.jpg"),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                    right: 3,
                    bottom: 3,
                    child: renderCategoryPrimary(context, item.category))
              ],
            ),
          ),
          SizedBox(
            width: kDefaultPaddingWidget.w,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.ventorName,
                style: searchRecentTitle,
              ),
              SizedBox(
                height: 6.h,
              ),
              Text(
                item.ventorAddress,
                maxLines: 2,
                style: searchRecentSubTitle.copyWith(height: 1.1),
              )
            ],
          )),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
    );
  }
}

Widget renderCategoryIcon(BuildContext context, CategoryEnum category) {
  switch (category) {
    case CategoryEnum.bar:
      return Image.asset(AppPath.barIconGrey, width: 26.w, height: 26.w);
    case CategoryEnum.karaoke:
      return Image.asset(AppPath.karaokeIconGrey, width: 26.w, height: 26.w);
    case CategoryEnum.massage:
      return Image.asset(AppPath.massageIconGrey, width: 26.w, height: 26.w);
    case CategoryEnum.restaurant:
      return Image.asset(AppPath.restaurantIconGrey, width: 26.w, height: 26.w);
    default:
      return Container();
  }
}

Widget renderCategoryPrimary(BuildContext context, CategoryType category) {
  return Container(
    width: 20.w,
    height: 20.w,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: HexColor(textColor),
        borderRadius: BorderRadius.circular(defaultBorderRadius)),
    child: Image.asset(getPathIcon(category), width: 15.w, height: 15.w),
  );
}

Widget renderCategorySecondary(BuildContext context, String category) {
  return Container(
    width: 80.w,
    height: 36.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        border: Border.all(color: HexColor(secondaryColorLight), width: 1),
        borderRadius: BorderRadius.circular(defaultBorderRadius)),
    child: Text(
      category,
      style: subTitleStyle,
    ),
  );
}
