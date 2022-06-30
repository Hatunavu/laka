import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/screen/profile/affiliate/history/affiliate_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AffiliateFirstLevel extends StatelessWidget {
  const AffiliateFirstLevel({Key? key, required this.firstLevel})
      : super(key: key);
  final List<AccountModel> firstLevel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kDefaultPaddingWidget.h, horizontal: kDefaultPaddingItem.w),
      child: firstLevel.isEmpty
          ? Text("notHaveLevel1Referrer".tr, style: titleStyle)
          : ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              itemCount: firstLevel.length,
              itemBuilder: (context, index) {
                final item = firstLevel[index];
                return renderAffiliatePerson(context, item);
              }),
    );
  }
}
