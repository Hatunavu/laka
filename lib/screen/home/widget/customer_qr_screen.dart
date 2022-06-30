import 'dart:io';

import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/screen/home/widget/scan_qr_tab.dart';
import 'package:client_tggt/screen/home/widget/show_qr_tab.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_route/auto_route.dart';

class CustomerQrScreen extends StatefulWidget {
  const CustomerQrScreen({Key? key}) : super(key: key);
  @override
  _CustomerQrScreenState createState() => _CustomerQrScreenState();
}

class _CustomerQrScreenState extends State<CustomerQrScreen> {
  @override
  Widget build(BuildContext context) {
    // controller.resumeCamera();
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            titleTextStyle: titleStyle,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  context.router.pop();
                },
                icon: Icon(
                  Ionicons.close_circle_outline,
                  size: 23.sp,
                  color: Theme.of(context).backgroundColor,
                )),
            bottom: TabBar(
              labelColor: Theme.of(context).backgroundColor,
              labelStyle:
                  titleStyle.copyWith(color: Theme.of(context).backgroundColor),
              unselectedLabelColor:
                  ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight,
              unselectedLabelStyle: subTitleStyle,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: const [
                Tab(
                  text: "Mã Giới thiệu",
                ),
                Tab(text: "Quét mã Qr"),
              ],
            ),
          ),
          body: TabBarView(
            children: [ShowQrTab(), const ScanQrTab()],
          ),
        ),
      ),
    );
  }
}
