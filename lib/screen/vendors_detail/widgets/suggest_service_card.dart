import 'dart:developer';

import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestServiceCard extends StatelessWidget {
  const SuggestServiceCard({
    Key? key,
    required this.listSuggestedServices,
    required this.callback,
  }) : super(key: key);

  final List<VendorModel> listSuggestedServices;
  final Function(String id, String category, VendorModel vendorInfo) callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 200.h,
      child: ListView.builder(
        padding: EdgeInsets.only(
            right: listSuggestedServices.length <= 1
                ? kDefaultPaddingScreen.w
                : 0),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: listSuggestedServices.length,
        itemBuilder: (ctx, index) {
          return Container(
            // width: MediaQuery.of(ctx).size.width - kDefaultPaddingScreen.w * 2,
            padding:
                EdgeInsets.only(left: index > 0 ? kDefaultPaddingScreen.w : 0),
            child: VendorItem(
              //isFullWidth: false,
              price: "300.000đ",
              vendorInfo: listSuggestedServices[index],
              onPress: () {
                callback(
                  listSuggestedServices[index].id ?? '',
                  listSuggestedServices[index].category.getType(),
                  listSuggestedServices[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
