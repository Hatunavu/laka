import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor_page/booking/menu/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class VendorsMenuItemSecondary extends StatelessWidget {
  const VendorsMenuItemSecondary(
      {Key? key,
      required this.item,
      this.onSelect,
      this.amount,
      this.onSubAmount,
      this.onAddAmount,
      required this.isSelected})
      : super(key: key);
  final MenuModel item;
  final Function()? onSelect;
  final Function()? onSubAmount;
  final Function()? onAddAmount;
  final bool isSelected;
  final int? amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h, top: 8.h),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3.w, color: Colors.grey))),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  onSelect?.call();
                },
                child: Container(
                  padding:
                      EdgeInsets.only(right: 10.w, top: 10.w, bottom: 10.w),
                  child: Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.r),
                        border: Border.all(
                            width: 0.6,
                            color: isSelected == true
                                ? kColorPrimaryLight
                                : kColorTextGrey)),
                    child: isSelected == true
                        ? Icon(
                            Ionicons.checkmark_outline,
                            size: 16.sp,
                            color: kColorPrimaryLight,
                          )
                        : Container(),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
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
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp),
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
                                    style:
                                        subTitleStyle.copyWith(fontSize: 12.sp),
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
                                        fontSize: 13.sp,
                                        color: kColorPrimaryLight),
                                  ),
                                ),
                              ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: isSelected == true ? kDefaultPaddingItem.h : 0,
          ),
          isSelected == true
              ? Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            onSubAmount?.call();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Icon(
                                Ionicons.remove_outline,
                                size: 12.sp,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 2.h, left: 20.w, right: 20.w),
                          padding: EdgeInsets.zero,
                          child: Text(
                            "$amount",
                            style: titleStyle,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onAddAmount?.call();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: kColorPrimaryLight),
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Icon(
                                Ionicons.add_outline,
                                size: 12.sp,
                                color: kColorPrimaryLight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
