import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/enum/account_type.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/model/vendor/review_model.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/model/voucher/enum_voucher_status.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/auth/signin/sigin_telephone_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_controller.dart';
import 'package:client_tggt/screen/auth/signin/signin_verify_controller.dart';
import 'package:client_tggt/screen/auth/signup/signup_controller.dart';
import 'package:client_tggt/screen/auth/verify/verify_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/message/widget/post_item.dart';
import 'package:client_tggt/screen/notification/notification_controller.dart';
import 'package:client_tggt/screen/order/order_screen.dart';
import 'package:client_tggt/screen/profile/message/message_detail_controller.dart';
import 'package:client_tggt/screen/profile/message/staff/widget/customer_staff_item.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/screen/review/review_controller.dart';
import 'package:client_tggt/screen/rewards/voucher/voucher_screen.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/appbar_header.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/bonus_service_card.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/introduce_card.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/label_with_icon.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/review_card.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/service_card.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/suggest_service_card.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:client_tggt/shared/widget/rating/rating_review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VendorsDetailScreen extends StatefulWidget {
  VendorsDetailScreen({
    Key? key,
    this.first,
    this.last,
    this.tagId,
    this.imageUrl,
    this.vendorTitle,
    required this.vendorsInfo,
    this.voucher,
  }) : super(key: key);
  final String? first;
  final String? last;
  final String? tagId;
  final String? imageUrl;
  final String? vendorTitle;
  final VendorModel vendorsInfo;
  final VoucherModel? voucher;
  @override
  State<VendorsDetailScreen> createState() => _VendorsDetailScreenState();
}

class _VendorsDetailScreenState extends State<VendorsDetailScreen> {
  VendorsDetailController controller =
      Get.put(VendorsDetailController(getIt.get<ApiClient>()));
  var isVendors = false;
  late String? last;
  late String? first;
  late String? tagId;
  late String? imageUrl;
  late String? vendorTitle;
  late VendorModel vendorsInfo;
  late VoucherModel? voucher;

  @override
  void initState() {
    super.initState();
    setState(() {
      last = widget.last;
      first = widget.first;
      tagId = widget.tagId;
      imageUrl = widget.imageUrl;
      vendorTitle = widget.vendorTitle;
      vendorsInfo = widget.vendorsInfo;
      voucher = widget.voucher;
    });
    MainController mainController =
        Get.put(MainController(getIt.get<ApiClient>()));
    final account = mainController.account.value;
    if (account.vendor != null ||
        account.type == AccountType.vendor.getType()) {
      if (widget.vendorsInfo.id == account.vendor!.id) {
        setState(() {
          isVendors = true;
        });
      }
    }
    if (widget.voucher != null) {
      controller.setVoucher(widget.voucher!);
    }
    controller.setID(widget.first ?? '', widget.last ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> bonusServices = {
      "assets/images/parking.png": "Chỗ để xe",
      "assets/images/wifi.png": "Wifi miễn phí",
    };
    return Scaffold(
      body: Obx(() => Hero(
            transitionOnUserGestures: false,
            tag: tagId ?? '',
            child: Container(
              padding: EdgeInsets.zero,
              child: CustomScrollView(
                controller: controller.scrollController.value,
                slivers: [
                  buildHeader(context, controller, vendorsInfo),
                  Obx(() => buildBody(context, bonusServices, controller,
                      vendorsInfo, isVendors)),
                ],
              ),
            ),
          )),
    );
  }

  SliverToBoxAdapter buildBody(
      BuildContext context,
      Map<String, String> bonusServices,
      VendorsDetailController controller,
      VendorModel vendorsInfo,
      bool isVendor) {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Container(
          // padding: EdgeInsets.all(kDefaultPadding.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kDefaultPadding.h,
              ),
              buildTitle(context, controller, vendorsInfo),
              SizedBox(height: 6.h),
              buildLocation(controller, vendorsInfo),
              // renderLine(context),
              controller.isFetchAllData.isTrue
                  ? renderTabService(context)
                  : Container(),

              controller.isLoading.isTrue
                  ? const LoadingScreen()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.tabIndex.value == 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildFirstProduct(controller),
                                SizedBox(height: kDefaultPaddingItem.h),
                                buildIntroduce(controller),
                                SizedBox(height: kDefaultPaddingWidget.h),
                                buildRatingAndReview(
                                    context, bonusServices, controller),
                                SizedBox(height: kDefaultPaddingWidget.h),
                                buildBonusService(controller),
                                buildServices(context, controller),
                              ],
                            ),
                          ),

                        if (controller.tabIndex.value == 1)
                          renderListStaff(context),

                        if (controller.tabIndex.value == 3)
                          renderListNewfeed(context),

                        if (controller.tabIndex.value == 2)
                          renderListVoucher(context),

                        // buildVarientServices(context, controller),
                        // SizedBox(height: kDefaultPaddingWidget.h),
                        buildSimilarVendor(controller),
                      ],
                    ),
              SizedBox(
                height: kDefaultPadding.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget renderListNewfeed(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaultPaddingItem.h),
      width: MediaQuery.of(context).size.width,
      child: controller.listPosts.isEmpty
          ? Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
              child: Text(
                  "Chưa có bài viết trên công đồng chia sẻ về $vendorTitle",
                  style: subTitleStyle.copyWith(height: 1.5),
                  textAlign: TextAlign.center))
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
              primary: false,
              // ignore: invalid_use_of_protected_member
              itemCount: controller.listPosts.value.length,
              itemBuilder: (context, int index) {
                final PostModel item =
                    // ignore: invalid_use_of_protected_member
                    controller.listPosts.value[index];
                return PostItem(
                    post: item,
                    index: index,
                    onPressReaction: () {
                      controller.handleUpdatePostReaction(item.id, "love");
                    });
              }),
    );
  }

  Widget renderListVoucher(BuildContext context) {
    final listVoucherSystem = controller.listVoucher
        .where((item) => item.type == VoucherType.system)
        .toList();
    final listVoucherVendor = controller.listVoucher
        .where((item) => item.type == VoucherType.vendor)
        .toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
      margin: EdgeInsets.only(
          top: kDefaultPaddingWidget.h, bottom: kDefaultPaddingWidget.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: listVoucherSystem.isNotEmpty,
            child: Container(
                padding: EdgeInsets.zero,
                child: Text("Laka voucher", style: titleStyle)),
          ),
          Visibility(
            visible: listVoucherSystem.isNotEmpty,
            child: SizedBox(
              height: kDefaultPaddingWidget.h,
            ),
          ),
          Visibility(
            visible: listVoucherSystem.isNotEmpty,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listVoucherSystem.length,
                  itemBuilder: (context, index) {
                    final item = listVoucherSystem[index];
                    return renderVoucherItem(context, item);
                  }),
            ),
          ),
          SizedBox(
            height: kDefaultPaddingWidget.h,
          ),
          Visibility(
            visible: listVoucherVendor.isNotEmpty,
            child: Container(
                padding: EdgeInsets.zero,
                child: Text('$vendorTitle voucher', style: titleStyle)),
          ),
          Visibility(
            visible: listVoucherVendor.isNotEmpty,
            child: SizedBox(
              height: kDefaultPaddingWidget.h,
            ),
          ),
          Visibility(
            visible: listVoucherVendor.isNotEmpty,
            child: Container(
              padding: EdgeInsets.zero,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listVoucherVendor.length,
                  itemBuilder: (context, index) {
                    final item = listVoucherVendor[index];
                    return renderVoucherItem(context, item);
                  }),
            ),
          ),
          Visibility(
              visible: controller.selectedVoucher.value.id == "100000000",
              child: Container(
                padding: EdgeInsets.zero,
                child: Text(controller.selectedVoucher.value.id),
              ))
        ],
      ),
    );
  }

  Widget renderVoucherItem(BuildContext context, VoucherModel item) {
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
                                        image: CachedNetworkImageProvider(widget
                                                .vendorsInfo.gallery![0].path ??
                                            ""),
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
                controller.selectedVoucher.value.id == item.id
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
                        ? GestureDetector(
                            onTap: () {
                              controller.selectedVoucher.value = item;
                              EasyLoading.showSuccess("Đã lưu mã giảm giá");
                            },
                            child: Container(
                              height: 68.h,
                              margin: EdgeInsets.only(
                                  bottom: kDefaultPaddingItem.h),
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
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

  Widget buildFirstProduct(VendorsDetailController controller) {
    return (controller.currentVendor.value.products ?? []).isNotEmpty
        ? ServiceCard(
            haveImage: false,
            isVendors: isVendors,
            callback: () {
              Scrollable.ensureVisible(
                controller.dataKey.currentContext!,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            product: controller.currentVendor.value.products?.first ??
                ServicesModel(),
            category: controller.currentVendor.value.category,
          )
        : const SizedBox();
  }

  Widget buildTitle(BuildContext context, VendorsDetailController controller,
      VendorModel vendorsInfo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            vendorsInfo.brandName,
            style: AppTextStyle().heading2Semi20,
            maxLines: 3,
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Center(
                    child: Text(
                      vendorsInfo.category.display(),
                      style: AppTextStyle().subtitleRegular14,
                    ),
                  ),
                  SizedBox(width: kDefaultPaddingItem.w),
                  BuildRatingReview(
                      starCount: controller.isLoading.isFalse
                          ? controller.currentVendor.value.avgRating ?? 0.0
                          : vendorsInfo.avgRating ?? 0.0,
                      reviewCount: controller.isLoading.isFalse
                          ? controller.currentVendor.value.totalReviews ?? 0
                          : vendorsInfo.totalReviews ?? 0),
                ],
              ),
              isVendors == false
                  ? GestureDetector(
                      onTap: () {
                        final userToken = AccountServices().getUserToken();
                        if (userToken == "") {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: const Text("Thông báo"),
                                    content: const Text(
                                        "Vui lòng đăng nhập để gửi tin nhắn."),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: const Text("Xác nhận"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                  ));
                        } else {
                          context.router
                              .push(MessageDetailPage(
                                  roomId: "",
                                  vendorId:
                                      controller.currentVendor.value.id ?? "",
                                  vendorInfo: controller.currentVendor.value))
                              .then((value) =>
                                  {Get.delete<MessageDetailController>()});
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingItem.w, vertical: 6.h),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 0.3.w, color: Colors.grey),
                            borderRadius: BorderRadius.circular(6.r)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text("Gửi tin nhắn",
                            //     style: TextStyle(
                            //         fontSize: 10.sp,
                            //         color: ThemeServices().isDarkMode
                            //             ? Colors.grey[400]
                            //             : Colors.grey[600]))
                            Icon(
                              Ionicons.chatbox_ellipses_outline,
                              color: ThemeServices().isDarkMode
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                              size: 15.sp,
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              margin: EdgeInsets.only(top: 2.h),
                              child: Text("Nhắn tin",
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: ThemeServices().isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[600])),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ],
      ),
    );
  }

  Obx buildIntroduce(VendorsDetailController controller) {
    return Obx(() =>
        IntroduceCard(content: controller.currentVendor.value.details ?? ""));
  }

  Widget buildServices(
      BuildContext context, VendorsDetailController controller) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        key: controller.dataKey,
        children: [
          ...(controller.currentVendor.value.products ?? []).map((e) {
            return Column(
              children: [
                ServiceCard(
                  isDisable: (e.quantity ?? 0) <= 0,
                  isVendors: isVendors,
                  callback: () {
                    final MainController mainController =
                        Get.put(MainController(getIt.get<ApiClient>()));
                    var textfieldController = TextEditingController();
                    mainController.userToken.value == ""
                        ? showAlertDialog(
                            context: context,
                            title: 'Đăng nhập để đặt lịch',
                            content: 'Bạn sẽ đặt được lịch sau khi đăng nhập',
                            cancelActionText: 'Huỷ',
                            defaultActionText: 'Đăng nhập')
                        : showModalBottomSheet(
                            context: context,
                            builder: (context) => Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: OrderScreen(
                                id: e.id ?? "",
                                textfieldController: textfieldController,
                                type: e.name ?? '',
                                voucher: controller.selectedVoucher.value,
                                vendorInfo: vendorsInfo,
                              ),
                            ),
                            isScrollControlled: true,
                            enableDrag: true,
                            backgroundColor: Theme.of(context).backgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.r),
                                topRight: Radius.circular(24.r),
                              ),
                            ),
                          );
                    //.then((value) => Get.delete<OrderController>());
                  },
                  product: e,
                  category: controller.currentVendor.value.category,
                ),
                SizedBox(height: kDefaultPadding.h),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget buildVarientServices(
      BuildContext context, VendorsDetailController controller) {
    final varient = controller.currentVendor.value.variants;
    if (varient == null) return Container();
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      child: Column(
        key: controller.dataKey,
        children: [
          varient.isEmpty
              ? Container()
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: varient.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final varientItem = varient[index];
                    if (varientItem.products!.isEmpty) return Container();
                    final firstProductInVarient = varientItem.products![0];
                    return Container(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  varientItem.name,
                                  style: titleStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.sp),
                                ),
                                // Container(
                                //   padding: EdgeInsets.zero,
                                //   child: Row(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       children: [
                                //         Text("Xem tất cả", style: subTitleStyle)
                                //       ]),
                                // )
                              ],
                            ),
                            SizedBox(
                              height: kDefaultPaddingScreen.h,
                            ),
                            ServiceCard(
                              isDisable: false,
                              isVendors: isVendors,
                              callback: () {
                                final MainController mainController = Get.put(
                                    MainController(getIt.get<ApiClient>()));
                                var textfieldController =
                                    TextEditingController();
                                mainController.userToken.value == ""
                                    ? showAlertDialog(
                                        context: context,
                                        title: 'Đăng nhập để đặt lịch',
                                        content:
                                            'Bạn sẽ đặt được lịch sau khi đăng nhập',
                                        cancelActionText: 'Huỷ',
                                        defaultActionText: 'Đăng nhập')
                                    : mainController.currentOrders.value.id !=
                                            null
                                        ? showCupertinoDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                                  title:
                                                      Text("notification".tr),
                                                  content: const Text(
                                                      "Bạn có một lịch đặt chưa hoàn thành. Vui lòng đặt lịch lại sau!"),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: Text('confirm'.tr),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        // context.router.pop(false);
                                                      },
                                                    ),
                                                  ],
                                                ))
                                        : showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: OrderScreen(
                                                id: firstProductInVarient.id ??
                                                    "",
                                                textfieldController:
                                                    textfieldController,
                                                type: firstProductInVarient
                                                        .name ??
                                                    '',
                                                voucher: controller
                                                    .selectedVoucher.value,
                                                vendorInfo: vendorsInfo,
                                              ),
                                            ),
                                            isScrollControlled: true,
                                            enableDrag: true,
                                            backgroundColor: Theme.of(context)
                                                .backgroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(24.r),
                                                topRight: Radius.circular(24.r),
                                              ),
                                            ),
                                          );
                              },
                              category: controller.currentVendor.value.category,
                              product: firstProductInVarient,
                            ),
                            SizedBox(height: 8.h),
                            Visibility(
                                visible: varientItem.products!.length > 2,
                                child: InkWellButton.outline(
                                  label: "Xem tất cả combo",
                                  borderRadius: BorderRadius.circular(10.r),
                                  onPressed: () {
                                    context.router.push(ProductsOfVarientPage(
                                        variant: varientItem,
                                        isVendors: isVendors,
                                        onBack: (ServicesModel productItem) {
                                          final MainController mainController =
                                              Get.put(MainController(
                                                  getIt.get<ApiClient>()));
                                          var textfieldController =
                                              TextEditingController();
                                          mainController.userToken.value == ""
                                              ? showAlertDialog(
                                                  context: context,
                                                  title:
                                                      'Đăng nhập để đặt lịch',
                                                  content:
                                                      'Bạn sẽ đặt được lịch sau khi đăng nhập',
                                                  cancelActionText: 'Huỷ',
                                                  defaultActionText:
                                                      'Đăng nhập')
                                              : mainController.currentOrders
                                                          .value.id !=
                                                      null
                                                  ? Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                      showCupertinoDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CupertinoAlertDialog(
                                                                title: Text(
                                                                    "notification"
                                                                        .tr),
                                                                content: const Text(
                                                                    "Bạn có một lịch đặt chưa hoàn thành. Vui lòng đặt lịch lại sau!"),
                                                                actions: [
                                                                  CupertinoDialogAction(
                                                                    child: Text(
                                                                        'confirm'
                                                                            .tr),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      // context.router.pop(false);
                                                                    },
                                                                  ),
                                                                ],
                                                              ));
                                                    })
                                                  : Future.delayed(
                                                      const Duration(
                                                          milliseconds: 500),
                                                      () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) =>
                                                            Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: OrderScreen(
                                                            id: productItem
                                                                    .id ??
                                                                "",
                                                            textfieldController:
                                                                textfieldController,
                                                            type: productItem
                                                                    .name ??
                                                                '',
                                                            voucher: controller
                                                                .selectedVoucher
                                                                .value,
                                                            vendorInfo: widget
                                                                .vendorsInfo,
                                                          ),
                                                        ),
                                                        isScrollControlled:
                                                            true,
                                                        enableDrag: true,
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .backgroundColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    24.r),
                                                            topRight:
                                                                Radius.circular(
                                                                    24.r),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                        }));
                                  },
                                )),
                            SizedBox(height: kDefaultPadding.h),
                          ],
                        ));
                  },
                ),
        ],
      ),
    );
  }

  Future<dynamic> showAlertDialog2({
    required BuildContext context,
    required String title,
    required String content,
    required String cancelActionText,
  }) async {
    if (!GetPlatform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: Text(cancelActionText),
              onPressed: () {
                context.router.pop();
              },
            ),
          ],
        ),
      );
    }

    // todo : showDialog for ios
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () {
              context.router.pop();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String cancelActionText,
    required String defaultActionText,
  }) async {
    if (!GetPlatform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: Text(cancelActionText),
              onPressed: () {
                context.router.pop(false);
              },
            ),
            ElevatedButton(
              child: Text(defaultActionText),
              onPressed: () {
                Get.delete<MainController>();
                Get.delete<HomeController>();
                Get.delete<ProfileController>();
                Get.delete<NotificationController>();
                Get.delete<NewfeedController>();
                Get.delete<VerifyController>();
                Get.delete<SigninVerifyController>();
                Get.delete<SigninController>();
                Get.delete<SignupController>();
                Get.delete<SigninTelephoneController>();
                context.router.replace(const SigninTelephonePage());
              },
            ),
          ],
        ),
      );
    }

    // todo : showDialog for ios
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () {
              context.router.pop(false);
            },
          ),
          CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: () {
              Get.delete<MainController>();
              Get.delete<HomeController>();
              Get.delete<ProfileController>();
              Get.delete<NotificationController>();
              Get.delete<NewfeedController>();
              Get.delete<VerifyController>();
              Get.delete<SigninVerifyController>();
              Get.delete<SigninController>();
              Get.delete<SignupController>();
              Get.delete<SigninTelephoneController>();
              context.router.replace(const SigninTelephonePage());
            },
          ),
        ],
      ),
    );
  }

  Widget buildSimilarVendor(VendorsDetailController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("similarService".tr, style: AppTextStyle().titleBold16),
          SizedBox(height: kDefaultPaddingWidget.h),
          Obx(() => SuggestServiceCard(
                // ignore: invalid_use_of_protected_member
                listSuggestedServices: controller.listSuggestedServices.value,
                callback: (id, category, vendorInfo) {
                  controller.updateSimilarVendor(vendorInfo, vendorsInfo);
                  setState(() {
                    last = vendorInfo.category.getType();
                    first = vendorInfo.id ?? '';
                    tagId = "similar-${vendorInfo.id}";
                    imageUrl = vendorInfo.thumbnail?.path ?? "";
                    vendorTitle = vendorInfo.brandName;
                    vendorsInfo = vendorInfo;
                    voucher = null;
                  });
                  controller.reloadSetId(id, category);
                },
              )),
        ],
      ),
    );
  }

  Widget buildBonusService(VendorsDetailController controller) {
    return Container(
      // padding: EdgeInsets.only(bottom: kDefaultPaddingItem.h),
      // decoration: BoxDecoration(
      //     border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5.w))),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("includedAmenities".tr, style: AppTextStyle().heading3Semi18),
          // SizedBox(height: kDefaultPaddingWidget.h),
          Obx(() => BonusServiceCard(
              attributeServices:
                  controller.currentVendor.value.attributes ?? [])),
        ],
      ),
    );
  }

  Widget buildLocation(
      VendorsDetailController controller, VendorModel vendorsInfo) {
    return LabelWithIcon(
        icon: Icons.location_on, label: vendorsInfo.address.fullAddress);
  }

  Widget buildHeader(BuildContext context, VendorsDetailController controller,
      VendorModel vendorsInfo) {
    return BuildAppbarHeader(
      // listImage: controller.currentVendor.value.gallery ?? [],
      // imageCount: controller.currentVendor.value.gallery?.length ?? 0,
      listImage: vendorsInfo.gallery ?? [],
      imageCount: vendorsInfo.gallery == null ? 0 : vendorsInfo.gallery!.length,
      // isPinned: controlle r.isPinned.value,
    );
  }

  Widget buildRatingAndReview(BuildContext context,
      Map<String, String> bonusServices, VendorsDetailController controller) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          buildRating(context, controller),
          if (controller.currentVendor.value.totalReviews != 0)
            buildReview(context, controller),
        ],
      ),
    );
  }

  Container buildRating(
      BuildContext context, VendorsDetailController controller) {
    return controller.currentVendor.value.avgRating == null
        ? Container()
        : Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ratingsAndReviews".tr,
                        style: AppTextStyle().heading3Semi18),
                    // ElevatedButton(
                    //     onPressed: () {},
                    //     child: const Text("Toàn bộ"),
                    //     style: roundedButtonStyle),
                  ],
                ),
                SizedBox(height: kDefaultPaddingItem.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  margin: EdgeInsets.only(bottom: 6.h),
                                  child: Icon(
                                    Ionicons.star_sharp,
                                    color: Theme.of(context).primaryColor,
                                    size: 16.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: kDefaultPaddingItem.w,
                                ),
                                AutoSizeText(
                                  TGGTUtils().formatNumber(controller
                                          .currentVendor.value.avgRating ??
                                      0.0),
                                  style: priceTitleStyle.copyWith(
                                      fontSize: 16.sp,
                                      height: 1.2,
                                      color: ThemeServices().isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.black),
                                  maxLines: 1,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: ' - ',
                                    style: priceTitleStyle.copyWith(
                                        fontSize: 16.sp,
                                        height: 1.2,
                                        color: ThemeServices().isDarkMode
                                            ? Colors.grey[400]
                                            : Colors.black),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '${controller.currentVendor.value.totalReviews ?? 0} ${'reviews'.tr}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    // Flexible(
                    //   flex: 7,
                    //   child: RatingBar(
                    //       ratings:
                    //           controller.currentVendor.value.reviewStatistics ?? [],
                    //       totalRating:
                    //           controller.currentVendor.value.totalReviews ?? 0),
                    // ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget renderTabService(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingItem.w),
      margin: EdgeInsets.only(
          bottom: kDefaultPaddingItem.h, top: kDefaultPaddingWidget.h),
      child: Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                controller.tabIndex.value = 0;
              },
              child: Container(
                height: 28.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.tabIndex.value == 0
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.r),
                      bottomLeft: Radius.circular(6.r)),
                  border: Border.all(
                      width: controller.tabIndex.value == 0 ? 0 : 0.5.w,
                      color: controller.tabIndex.value == 0
                          ? Theme.of(context).primaryColor
                          : ThemeServices().isDarkMode
                              ? kColorGreyDark
                              : kColorGreyLight),
                ),
                child: Text("Dịch vụ",
                    style: subTitleStyle.copyWith(
                        fontSize: 12.sp,
                        color: controller.tabIndex.value == 0
                            ? Theme.of(context).backgroundColor
                            : ThemeServices().isDarkMode
                                ? kColorGreyDark
                                : kColorGreyLight)),
              ),
            )),
            Visibility(
              visible: controller.listStaff.isNotEmpty,
              child: Expanded(
                  child: GestureDetector(
                onTap: () {
                  controller.tabIndex.value = 1;
                },
                child: Container(
                  height: 28.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: controller.tabIndex.value == 1
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).backgroundColor,
                      border: Border(
                          top: BorderSide(
                              width: 0.5.w,
                              color: controller.tabIndex.value == 1
                                  ? Theme.of(context).primaryColor
                                  : ThemeServices().isDarkMode
                                      ? kColorGreyDark
                                      : kColorGreyLight),
                          bottom: BorderSide(
                              width: 0.5.w,
                              color: controller.tabIndex.value == 1
                                  ? Theme.of(context).primaryColor
                                  : ThemeServices().isDarkMode
                                      ? kColorGreyDark
                                      : kColorGreyLight))),
                  child: Text("KTV",
                      style: subTitleStyle.copyWith(
                          fontSize: 12.sp,
                          color: controller.tabIndex.value == 1
                              ? Theme.of(context).backgroundColor
                              : ThemeServices().isDarkMode
                                  ? kColorGreyDark
                                  : kColorGreyLight)),
                ),
              )),
            ),
            Visibility(
              visible: controller.listVoucher.isNotEmpty,
              child: Expanded(
                  child: GestureDetector(
                onTap: () {
                  controller.tabIndex.value = 2;
                },
                child: Container(
                  height: 28.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: controller.tabIndex.value == 2
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).backgroundColor,
                      border: Border(
                          left: BorderSide(
                              width: 0.5.w,
                              color: controller.tabIndex.value == 2
                                  ? Theme.of(context).primaryColor
                                  : ThemeServices().isDarkMode
                                      ? kColorGreyDark
                                      : kColorGreyLight),
                          top: BorderSide(
                              width: 0.5.w,
                              color: controller.tabIndex.value == 2
                                  ? Theme.of(context).primaryColor
                                  : ThemeServices().isDarkMode
                                      ? kColorGreyDark
                                      : kColorGreyLight),
                          bottom: BorderSide(
                              width: 0.5.w,
                              color: controller.tabIndex.value == 2
                                  ? Theme.of(context).primaryColor
                                  : ThemeServices().isDarkMode
                                      ? kColorGreyDark
                                      : kColorGreyLight))),
                  child: Text("Giảm giá",
                      style: subTitleStyle.copyWith(
                          fontSize: 12.sp,
                          color: controller.tabIndex.value == 2
                              ? Theme.of(context).backgroundColor
                              : ThemeServices().isDarkMode
                                  ? kColorGreyDark
                                  : kColorGreyLight)),
                ),
              )),
            ),
            Expanded(
                child: GestureDetector(
              onTap: () {
                controller.tabIndex.value = 3;
              },
              child: Container(
                height: 28.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: controller.tabIndex.value == 3
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6.r),
                        bottomRight: Radius.circular(6.r)),
                    border: Border.all(
                        width: controller.tabIndex.value == 3 ? 0 : 0.5.w,
                        color: controller.tabIndex.value == 3
                            ? Theme.of(context).primaryColor
                            : ThemeServices().isDarkMode
                                ? kColorGreyDark
                                : kColorGreyLight)),
                child: Text("Cộng đồng",
                    style: subTitleStyle.copyWith(
                        fontSize: 12.sp,
                        color: controller.tabIndex.value == 3
                            ? Theme.of(context).backgroundColor
                            : ThemeServices().isDarkMode
                                ? kColorGreyDark
                                : kColorGreyLight)),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget renderListStaff(BuildContext context) {
    final imageStaff = controller.listStaff
        .map((item) => GalleryModel(
            path: item.image, type: "image", pathUrl: item.image, id: "0"))
        .toList();
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding.w),
        margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
        // child: ListView.builder(
        //     shrinkWrap: true,
        //     padding: EdgeInsets.zero,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemCount: controller.listStaff.length,
        //     itemBuilder: (ctx, index) {
        //       final item = controller.listStaff[index];
        //       // return CustomerStaffItem(
        //       //     item: item, isSelected: false, isVendorDetail: true);
        //     }),
        child: GridView.builder(
          padding: EdgeInsets.only(top: kDefaultPaddingScreen.h),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 3 / 4,
            mainAxisSpacing: kDefaultPaddingScreen.w,
            crossAxisSpacing: kDefaultPaddingScreen.w,
          ),
          itemCount: controller.listStaff.length,
          itemBuilder: (context, index) {
            final item = controller.listStaff[index];

            return InkWell(
              onTap: () {
                context.router
                    .push(VendorsGalleryDetailPage(
                        index: index, listImage: imageStaff))
                    .then((value) {
                  Get.delete<VendorsGalleryDetailController>();
                });
                ;
              },
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: item.image,
                        memCacheHeight: 200,
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 28.sp,
                        ),
                      ),
                      SizedBox(
                        height: kDefaultPaddingItem.h,
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.name,
                          style: titleStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.description ?? "",
                          style: subTitleStyle.copyWith(fontSize: 12.sp),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )),
            );
          },
        ));
  }

  Column buildReview(BuildContext context, VendorsDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: kDefaultPaddingItem.h),
        Obx(
          () => Container(
            alignment: Alignment.topCenter,
            height: 170.h,
            padding: EdgeInsets.zero,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount:
                  (controller.currentVendor.value.reviews?.length ?? 0) > 2
                      ? 2
                      : controller.currentVendor.value.reviews?.length ?? 0,
              itemBuilder: (context, index) {
                final item = controller.currentVendor.value.reviews?[index] ??
                    ReviewModel();
                return Row(
                  children: [
                    ReviewCard(
                        userAvatar: item.reviewer?.profile?.avatar?.path ?? "",
                        userName: item.reviewer?.profile?.fullName ?? "",
                        starCount: item.rating ?? 0,
                        reviewDate: TGGTUtils().formatToTimeAgo(
                            item.createdAt ?? "0001-01-01T00:00"),
                        reviewContent: item.content ?? "",
                        listImage: item.gallery ?? []),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 35.h,
          child: Obx(
              // () => OutlinedRoundedButton(
              //   label:
              //       "${'see'.tr} ${controller.currentVendor.value.totalReviews} ${'reviews'.tr}",
              //   callback: () {
              //     context.router
              //         .push(
              //           ReviewPage(
              //               vendorID: controller.currentVendor.value.id ?? ''),
              //         )
              //         .then((value) => controller.setID(
              //             widget.first ?? '', widget.last ?? ''));
              //   },
              // ),
              () => GestureDetector(
                    onTap: () {
                      context.router
                          .push(
                        ReviewPage(
                            vendorID: controller.currentVendor.value.id ?? ''),
                      )
                          .then((value) {
                        Get.delete<ReviewController>();
                        // controller.setID(widget.first ?? '', widget.last ?? '');
                      });
                    },
                    child: Container(
                      height: 32.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 0.8.w),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Text(
                        "${'see'.tr} ${controller.currentVendor.value.totalReviews} ${'reviews'.tr}",
                        style: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}

Widget renderLine(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12.h),
    width: MediaQuery.of(context).size.width - kDefaultPaddingScreen.w,
    alignment: Alignment.center,
    height: 0.3.h,
    color: Colors.grey,
  );
}
