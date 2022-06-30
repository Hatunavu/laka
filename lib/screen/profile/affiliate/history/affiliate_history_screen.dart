import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/screen/profile/affiliate/widget/affiliate_firstlevel.dart';
import 'package:client_tggt/screen/profile/affiliate/widget/affiliate_secondlevel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AffiliateHistoryScreen extends StatelessWidget {
  const AffiliateHistoryScreen(
      {Key? key, required this.firstLevel, required this.secondLevel})
      : super(key: key);
  final List<AccountModel> firstLevel;
  final List<AccountModel> secondLevel;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: appBarTitleColor),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: Icon(
                Ionicons.chevron_back_outline,
                size: 22.sp,
                color: Theme.of(context).backgroundColor,
              )),
          bottom: TabBar(
            labelColor: Theme.of(context).backgroundColor,
            labelStyle:
                titleStyle.copyWith(color: Theme.of(context).backgroundColor),
            unselectedLabelColor: Colors.grey[50],
            unselectedLabelStyle: titleStyle.copyWith(
                fontSize: 14.sp, fontWeight: FontWeight.w400),
            indicatorColor: Theme.of(context).backgroundColor,
            tabs: [
              Tab(
                text: "level1".tr,
              ),
              Tab(text: "level2".tr),
            ],
          ),
          title: Text('shareHistory'.tr,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).backgroundColor)),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AffiliateFirstLevel(
              firstLevel: firstLevel,
            ),
            AffiliateSecondLevel(
              secondLevel: secondLevel,
            )
          ],
        ),
      ),
    );
  }
}

Widget renderAffiliatePerson(BuildContext context, AccountModel account) {
  return Container(
    padding: EdgeInsets.only(bottom: kDefaultPaddingItem.h, top: 10.h),
    decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.2.w, color: Colors.grey))),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: account.urlUserAvatar ?? "",
              memCacheHeight: 200,
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius: 23.sp,
              ),
            ),
            SizedBox(
              width: kDefaultPaddingItem.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  account.profile!.fullName ?? "",
                  style: titleStyle,
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  account.phone ?? "",
                  style: subTitleStyle.copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
