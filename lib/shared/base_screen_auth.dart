import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_route/auto_route.dart';

class BaseScreenAuth extends StatelessWidget {
  const BaseScreenAuth(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.leading,
      required this.body,
      this.elevation = 0.0,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.isLogin = true})
      : super(key: key);
  final String title;
  final String subTitle;
  final Widget? leading;
  final Widget body;
  final double? elevation;
  final MainAxisAlignment? mainAxisAlignment;
  final bool? isLogin;
  // final double
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: key,
        appBar: leading != null
            ? AppBar(
                elevation: elevation,
                backgroundColor: Theme.of(context).backgroundColor,
                leading: leading)
            : null,
        body: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Theme.of(context).backgroundColor,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .7,
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPaddingWidget.w),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppPath.logo,
                            color: Theme.of(context).primaryColor,
                            width: 100.w,
                            // height: 60,
                          ),
                          SizedBox(
                            height: kDefaultPaddingWidget.h * 1.5,
                          ),
                          Text(
                            title,
                            style: AppTextStyle().titleRegular16,
                          ),
                          Container(
                            child: body,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .3,
                        child: isLogin == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.all(defaultPaddingItem),
                                child: InkWell(
                                  onTap: () {
                                    final token =
                                        AccountServices().getUserToken();
                                    if (token == "") {
                                      AccountServices().saveUserToken("");
                                      AccountServices().saveUserId("");
                                      AccountServices().saveAccountType("");
                                    }
                                    context.router.replace(MainPage());
                                  },
                                  child: Icon(Ionicons.home,
                                      color: Theme.of(context).primaryColor),
                                ),
                              )
                            : null)
                  ],
                ),
              )),
        ));
  }
}
