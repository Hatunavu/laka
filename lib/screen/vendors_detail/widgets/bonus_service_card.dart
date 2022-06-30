import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BonusServiceCard extends StatelessWidget {
  const BonusServiceCard({
    Key? key,
    required this.attributeServices,
  }) : super(key: key);

  final List<AttributeModel> attributeServices;

  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
    //     padding: const EdgeInsets.only(top: 0, bottom: 0),
    //     physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 4,
    //       childAspectRatio: 1,
    //       mainAxisSpacing: kDefaultPaddingItem,
    //       crossAxisSpacing: kDefaultPaddingItem,
    //     ),
    //     itemCount: attributeServices.length,
    //     itemBuilder: (context, index) {
    //       return Column(
    //         children: [
    //           CachedNetworkImage(
    //             imageUrl: attributeServices[index].image!,
    //             height: 24.h,
    //             width: 24.w,
    //             color: Theme.of(context).primaryColor,
    //             placeholder: (context, url) =>
    //                 const CircularProgressIndicator(),
    //           ),
    //           SizedBox(height: kDefaultPaddingItem.h),
    //           Text(attributeServices[index].name,
    //               style: AppTextStyle().subtitleRegular14Grey,
    //               textAlign: TextAlign.center),
    //         ],
    //       );
    //     });
    inspect(attributeServices);
    return Container(
      alignment: Alignment.center,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            top: kDefaultPaddingItem.h, bottom: kDefaultPaddingItem.h),
        shrinkWrap: true,
        itemCount: attributeServices.length,
        itemBuilder: (ctx, index) {
          final item = attributeServices[index];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                // CachedNetworkImage(
                //   imageUrl: item.image!,
                //   height: 22.w,
                //   width: 22.w,
                //   memCacheHeight: 200,
                //   color: Theme.of(context).primaryColor,
                //   placeholder: (context, url) =>
                //       const CircularProgressIndicator(),
                // ),
                Container(
                  width: 26.w,
                  height: 26.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
                  child: Image.network(
                    item.image ??
                        "https://laka-storage-vn.hn.ss.bfcplatform.vn/data/images/vendors/hu2_dLMYq3Nm2dcacvory.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: kDefaultPaddingWidget.w,
                ),
                Text(item.name,
                    style: AppTextStyle().subtitleRegular14Grey,
                    textAlign: TextAlign.center),
              ],
            ),
          );
        },
      ),
    );
  }
}
