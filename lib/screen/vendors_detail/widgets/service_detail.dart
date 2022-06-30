import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceDetail extends StatelessWidget {
  const ServiceDetail({
    Key? key,
    required this.detail,
  }) : super(key: key);

  //final Map<IconData, String> serviceList;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Chi tiết dịch vụ", style: titleStyle),
          SizedBox(height: kDefaultPaddingWidget.h),
          Text(detail),
          // ...serviceList.entries.map((e) {
          //   return Column(
          //     children: [
          //       LabelWithIcon(
          //         icon: e.key,
          //         label: e.value,
          //         style: subTitleStyle.copyWith(
          //             color: HexColor(bottomTabDefaultLight)),
          //       ),
          //       SizedBox(height: kDefaultPaddingItem.h),
          //     ],
          //   );
          // }).toList()
        ],
      ),
    );
  }
}
