import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {Key? key,
      required this.callback,
      required this.product,
      this.haveImage = true,
      this.isDisable = false,
      required this.category,
      this.isVendors = false})
      : super(key: key);

  final Function() callback;
  final ServicesModel product;
  final bool haveImage;
  final bool isDisable;
  final bool? isVendors;
  final CategoryType category;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (haveImage) buildImageHeader(),
        buildTitlewithIcon(context),
        SizedBox(height: kDefaultPaddingItem.h),
        buildMoneyTitle(context, category),
        buildDescription(),
        buildListService(context),
        SizedBox(height: kDefaultPaddingItem.h),
        Visibility(
            visible: isVendors == false, child: buildPlaceOrderButton(context)),
      ],
    );
  }

  SizedBox buildPlaceOrderButton(BuildContext context) {
    return SizedBox(
      height: kDefaultButtonHeight35.h,
      width: Get.width,
      child: isDisable
          ? InkWellButton.disable(
              backgroundColor:
                  ThemeServices().isDarkMode ? kColorGreyDark : disableColor,
              textColor:
                  ThemeServices().isDarkMode ? kColorTextLight : disableText,
              onPressed: () {},
              label: "outOfSlot".tr,
              borderRadius: BorderRadius.circular(10.r),
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kColorBackgroundLight),
              //style: titleStyle.copyWith(color: kColorBackgroundLight),
            )
          : InkWellButton(
              textColor: Theme.of(context).backgroundColor,
              onPressed: callback,
              icon: Icon(
                Ionicons.calendar_outline,
                size: 16.sp,
                color: Theme.of(context).backgroundColor,
              ),
              textWithIcon: true,
              label: "placeOrder".tr,
              backgroundColor: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10.r),
              style: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: kColorBackgroundLight),
              //style: titleStyle.copyWith(color: kColorBackgroundLight),
            ),
    );
  }

  Column buildListService(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${'serviceDetail'.tr}:", style: AppTextStyle().subtitleRegular14),
        SizedBox(height: kDefaultPaddingItem.h),
        if (product.attributes?.isNotEmpty ?? false)
          ...?product.attributes?.map((e) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      width: 22.w,
                      height: 22.w,
                      child: SvgPicture.network(
                          // e.image ??
                          "https://laka-storage-vn.hn.ss.bfcplatform.vn/assets/images/128.svg",
                          color: Theme.of(context).primaryColor),
                    ),
                    // CachedNetworkImage(
                    //   imageUrl: e.image ?? '',
                    //   width: 22.w,
                    //   height: 22.w,
                    //   color: Theme.of(context).primaryColor,
                    //   errorWidget: (context, url, error) => SvgPicture.asset(
                    //     AppPath.lakaPoint,
                    //     color: Theme.of(context).backgroundColor,
                    //     width: 12.w,
                    //     // height: 60,
                    //   ),
                    // ),
                    SizedBox(width: kDefaultPaddingItem.w),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: AutoSizeText(
                          '${e.name} ${e.description}',
                          style: AppTextStyle().subtitleRegular14,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: kChipPadding.h),
              ],
            );
          })
        else
          Text('pleaseContact'.tr),
      ],
    );
  }

  Widget buildDescription() {
    return product.details != ''
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPaddingItem.h),
            child: Text(product.details ?? '',
                style:
                    AppTextStyle().subtitleRegular14Grey.copyWith(height: 1.5)),
          )
        : SizedBox(height: kDefaultPaddingItem.h);
  }

  Row buildMoneyTitle(BuildContext context, CategoryType category) {
    return Row(
      children: [
        Text(
            "Khoảng  ${TGGTUtils().formatMoney(product.price ?? 0)}đ / ${categoryTypeToSymbol(category)}",
            style: category == CategoryType.massage
                ? titleStyle.copyWith(color: Theme.of(context).primaryColor)
                : subTitleStyle),
      ],
    );
  }

  RichText buildTitlewithIcon(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: Theme.of(context).primaryColor),
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: IntrinsicWidth(
                child: Text(
                  "service".tr,
                  style: AppTextStyle()
                      .paragraphRegular12
                      .copyWith(color: Theme.of(context).backgroundColor),
                ),
              ),
            ),
          ),
          WidgetSpan(child: SizedBox(width: kDefaultPaddingItem.w)),
          TextSpan(
            text: product.name ?? '',
            style: AppTextStyle().titleRegular16.copyWith(height: 1.6),
          )
        ],
      ),
    );
  }

  Container buildImageHeader() {
    return Container(
      height: 130.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: CachedNetworkImageProvider(product.thumbnail?.path ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
