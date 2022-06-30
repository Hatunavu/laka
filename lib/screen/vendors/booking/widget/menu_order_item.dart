import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuOrderItem extends StatelessWidget {
  const MenuOrderItem({Key? key, required this.item}) : super(key: key);
  final SelectedMenuItemModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //     border: Border(bottom: BorderSide(width: 0.3.w, color: Colors.grey))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CachedNetworkImage(
                    imageUrl: item.item.image,
                    height: 30.w,
                    memCacheHeight: 800,
                    width: 30.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: kDefaultPaddingWidget.w,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(top: 3.h),
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: Text(
                      "${item.item.name}   x ${item.amount}",
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 13.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            child: Text(
              item.getTotalPrice.formatCurrency(),
              style: titleStyle.copyWith(fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
