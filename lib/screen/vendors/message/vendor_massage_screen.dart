import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/screen/vendors/message/message/vendor_message.dart';
import 'package:client_tggt/screen/vendors/message/notification/vendor_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class VendorMessageScreen extends StatelessWidget {
  const VendorMessageScreen({Key? key, this.tagId}) : super(key: key);
  final String? tagId;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleTextStyle: titleStyle,
            bottom: TabBar(
              labelColor: kColorPrimaryLight,
              labelStyle: titleStyle.copyWith(color: Colors.black),
              unselectedLabelColor: Colors.black,
              unselectedLabelStyle: subTitleStyle,
              indicatorColor: kColorPrimaryLight,
              tabs: [
                Tab(
                  text: "notification".tr,
                ),
                Tab(text: "message".tr),
              ],
            ),
            title: Text('message'.tr),
          ),
          body: const TabBarView(
            children: [VendorNotification(), VendorMessage()],
          ),
        ),
      ),
    );
  }
}
