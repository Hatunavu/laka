import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorsMenuItem extends StatelessWidget {
  const VendorsMenuItem({Key? key, required this.item}) : super(key: key);
  final MenuModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h, top: 8.h),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3.w, color: Colors.grey))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  height: 68.w,
                  memCacheHeight: 200,
                  width: 68.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.only(top: 3.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.name,
                          style: titleStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.description ?? "",
                          maxLines: 2,
                          style: subTitleStyle.copyWith(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.price.toInt().formatCurrency(),
                          style: titleStyle.copyWith(
                              fontSize: 13.sp, color: kColorPrimaryLight),
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
