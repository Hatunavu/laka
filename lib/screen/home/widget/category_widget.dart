import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatelessWidget {
  const Category(
      {Key? key,
      required this.title,
      required this.color,
      required this.imageurl})
      : super(key: key);
  final String title;
  final Color color;
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: const Offset(0, 1))
                  ]),
              child: Image.asset(
                imageurl,
                width: title == "Bar" ? 50.w : 24.w,
                height: title == "Bar" ? 50.h : 24.h,
                color: Theme.of(context).backgroundColor,
              )),
          SizedBox(height: kDefaultPaddingItem.w),
          Container(
            padding: const EdgeInsets.all(0),
            width: 90.w,
            child: Text(
              title,
              style: AppTextStyle().subtitleRegular14,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
