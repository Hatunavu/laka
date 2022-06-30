import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/shared/base_screen_secondary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchVendorScreen extends StatelessWidget {
  const SearchVendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreenSecondary(
      child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          padding: EdgeInsets.only(
              top: kDefaultPaddingWidget.h,
              left: kDefaultPaddingWidget.w,
              right: kDefaultPaddingWidget.w),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: const [Text("123")],
              ))),
    );
  }
}
