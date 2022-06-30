import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/model/voucher/enum_voucher_status.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/screen/rewards/voucher/voucher_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen(
      {Key? key,
      required this.onBack,
      required this.vendorId,
      this.vendorInfo,
      required this.selectedVoucher,
      required this.isSelectedVoucher})
      : super(key: key);
  final Function(
    VoucherModel voucher,
  )? onBack;
  final String vendorId;
  final VendorModel? vendorInfo;
  final VoucherModel selectedVoucher;
  final bool isSelectedVoucher;
  @override
  Widget build(BuildContext context) {
    final VoucherController controller =
        Get.put(VoucherController(getIt.get<ApiClient>()));
    controller.handleSetVendorId(vendorId);
    return BaseScreen(
      title: "voucher".tr,
      leading: IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: Icon(Icons.close_outlined,
            color: Theme.of(context).iconTheme.color),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        margin: EdgeInsets.symmetric(vertical: kDefaultPaddingItem.h),
        child: Column(
          children: [
            renderTab(context, controller),
            Obx(() => controller.isLoading.isTrue
                ? const LoadingScreen()
                : renderListVoucher(context, controller, vendorInfo!, onBack!,
                    selectedVoucher, isSelectedVoucher))
          ],
        ),
      ),
    );
  }
}

Widget renderTab(BuildContext context, VoucherController controller) {
  return Obx(() => Container(
        padding: EdgeInsets.zero,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          renderTabItem(context, controller, controller.listVoucherType[0]),
          renderTabItem(context, controller, controller.listVoucherType[1]),
          renderTabItem(context, controller, controller.listVoucherType[2])
        ]),
      ));
}

Widget renderTabItem(
    BuildContext context, VoucherController controller, VoucherType item) {
  return Expanded(
    child: InkWell(
      onTap: () {
        controller.handleChangeVoucherType(item);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
            color: controller.type.value == item.toJsonString()
                ? Colors.white
                : Colors.grey[100],
            borderRadius: BorderRadius.circular(3.r),
            border: Border.all(
                color: controller.type.value == item.toJsonString()
                    ? kColorPrimaryLight
                    : Colors.transparent)),
        margin: EdgeInsets.only(right: 6.w),
        child: Text(
          item.toJsonString(),
          style: TextStyle(
              color: controller.type.value == item.toJsonString()
                  ? ThemeServices().isDarkMode
                      ? kColorPrimaryDark
                      : kColorPrimaryLight
                  : ThemeServices().isDarkMode
                      ? kColorGreyDark
                      : Colors.black54),
        ),
      ),
    ),
  );
}

Widget renderListVoucher(
    BuildContext context,
    VoucherController controller,
    VendorModel vendorsInfo,
    Function(VoucherModel) onBack,
    VoucherModel selectedModel,
    bool isSelectedModel) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.listVoucher.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Text("cantFindCode".tr,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor)),
                )
              : Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.listVoucher.length,
                      itemBuilder: (context, index) {
                        final item = controller.listVoucher[index];
                        return renderVoucherItem(
                            context,
                            controller,
                            item,
                            vendorsInfo,
                            onBack,
                            selectedModel,
                            isSelectedModel);
                      }),
                ),
          Container()
        ],
      ),
    ),
  );
}

Widget renderVoucherItem(
    BuildContext context,
    VoucherController controller,
    VoucherModel item,
    VendorModel vendorInfo,
    Function(VoucherModel) onBack,
    VoucherModel selectedVoucher,
    bool isSelectedVoucher) {
  return GestureDetector(
    onTap: () {
      // context.router.push(VoucherDetailPage(voucherDetail: item));
    },
    child: Container(
      height: 76.h,
      padding: EdgeInsets.only(bottom: kDefaultPaddingItem.h),
      child: GestureDetector(
        child: Material(
          //Build Shadow
          color: Theme.of(context).backgroundColor,
          elevation: kdefaultElevated,
          borderRadius:
              BorderRadius.all(Radius.circular(defaultBorderRadius.r)),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    AspectRatio(
                        aspectRatio: 1,
                        child: item.type == VoucherType.system
                            ? Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                      color: ThemeServices().isDarkMode
                                          ? kColorPrimaryDark
                                          : kColorPrimaryLight,
                                      width: 0.5.w),
                                  // color: Theme.of(context).primaryColor,
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 50.w,
                                  height: 50.w,
                                  child: SvgPicture.asset(AppPath.logo,
                                      color: Theme.of(context).primaryColor,
                                      width: 36.w),
                                ))
                            : Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          vendorInfo.gallery![0].path ?? ""),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10.r),

                                  // color: Theme.of(context).primaryColor,
                                ),
                              )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingItem.w,
                            vertical: kDefaultPaddingItem.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              item.title,
                              maxLines: 2,
                              style: titleStyle.copyWith(fontSize: 12.sp),
                            ),
                            AutoSizeText(
                              'reduce'.tr +
                                  ' ${item.getDiscountAmount} ' +
                                  'forBillFrom'.tr +
                                  ' ${item.getMinBasketPrice}',
                              maxLines: 2,
                              style: subTitleStyle.copyWith(
                                  fontSize: 11.sp, height: 1.3),
                            ),
                            AutoSizeText(
                              item.expireDate,
                              maxLines: 2,
                              style: subTitleStyle.copyWith(
                                  fontSize: 10.sp, height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: kDefaultPaddingItem.w,
              ),
              selectedVoucher.id == item.id
                  ? Container(
                      height: 68.h,
                      alignment: Alignment.center,
                      child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Ionicons.checkmark_circle_outline,
                            color: Theme.of(context).primaryColor,
                            size: 23.sp,
                          )),
                    )
                  : item.status == VoucherStatusType.available
                      ? Container(
                          height: 68.h,
                          margin:
                              EdgeInsets.only(bottom: kDefaultPaddingItem.h),
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async {
                              await onBack.call(item);
                              context.router.pop();
                            },
                            child: Text(
                              "use".tr,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeServices().isDarkMode
                                      ? kColorPrimaryDark
                                      : kColorPrimaryLight),
                            ),
                          ),
                        )
                      : Container(),
              SizedBox(
                width: kDefaultPaddingItem.w,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
