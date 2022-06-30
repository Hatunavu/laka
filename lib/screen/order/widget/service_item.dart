import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem(
      {Key? key,
      required this.label,
      required this.value,
      required this.onSubtract,
      required this.onAdd,
      required this.onChanged,
      required this.minValue,
      required this.maxValue})
      : super(key: key);

  final String label;
  final int value;
  final Function() onSubtract;
  final Function() onAdd;
  final Function(int value) onChanged;
  final int minValue;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 3,
              child: Text(label, style: AppTextStyle().titleRegular16)),
          SizedBox(width: kDefaultPaddingItem.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  onSubtract();
                },
                child: Icon(
                  Ionicons.remove_circle,
                  color: kColorPrimaryLight,
                  size: 36.r,
                ),
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 4.0.h),
                child: NumberPicker(
                    value: value,
                    axis: Axis.horizontal,
                    itemWidth: 36.w,
                    itemHeight: 36.h,
                    minValue: minValue,
                    maxValue: maxValue,
                    haptics: true,
                    selectedTextStyle: AppTextStyle()
                        .heading2Bold20
                        .copyWith(color: kColorPrimaryLight),
                    onChanged: (value) => onChanged(value)),
              ),
              SizedBox(width: 8.w),
              InkWell(
                onTap: () {
                  onAdd();
                },
                child: Icon(
                  Ionicons.add_circle,
                  color: kColorPrimaryLight,
                  size: 36.r,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
