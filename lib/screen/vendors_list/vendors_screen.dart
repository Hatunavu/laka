import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/filter/price_range_model.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/tagline_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_controller.dart';
import 'package:client_tggt/screen/filter_vendors/widget/attribute_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/city_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/district_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/google_map.dart';
import 'package:client_tggt/screen/filter_vendors/widget/price_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/tagline_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/variant_popup.dart';
import 'package:client_tggt/screen/search/search_controller.dart';
import 'package:client_tggt/screen/search/widget/vendor_item_primary.dart';
import 'package:client_tggt/screen/vendors_list/vendors_controller.dart';
import 'package:client_tggt/screen/vendors_list/widgets/list_vendor_shimmer.dart';
import 'package:client_tggt/screen/vendors_list/widgets/vendors_item_third.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:client_tggt/shared/widget/popup_card/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indexed/indexed.dart';
import 'package:lottie/lottie.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({Key? key, this.category}) : super(key: key);
  final CategoryType? category;

  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {
  VendorsController controller =
      Get.put(VendorsController(getIt.get<ApiClient>()));
  @override
  void initState() {
    super.initState();
    controller.setCategory(widget.category ?? CategoryType.karaoke);
    getData();
    getDataFilter();
  }

  getData() async {
    Future.wait([
      controller.handleGetPoster(widget.category ?? CategoryType.karaoke),
      controller.getLocation(widget.category ?? CategoryType.karaoke)
    ]);
  }

  getDataFilter() async {
    Future.wait([
      controller.getListTagsLine(widget.category ?? CategoryType.karaoke),
      controller.getListSubCategory(widget.category ?? CategoryType.karaoke)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        backgroundColor: Theme.of(context).primaryColor,
        title: controller.categoryName.value,
        titleColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.delete<VendorsController>();
            context.router.pop();
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).backgroundColor),
        ),
        child:
            // () => CustomScrollView(
            //   // controller: controller.controller,
            //   controller: controller.scrollController.value,
            //   shrinkWrap: true,
            //   slivers: [
            //     renderPoster(context, controller),
            //     SliverStickyHeader(
            //         header: renderFilterData(context, controller),
            //         sliver: SliverList(
            //           delegate: SliverChildBuilderDelegate(
            //             (context, i) => vendorList(context, controller),
            //             childCount: 1,
            //           ),
            //         ))
            //   ],
            // ),
            Obx(() => Column(
                  children: [
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        //padding: const EdgeInsets.symmetric(horizontal: 8),
                        // color: Theme.of(context).backgroundColor,
                        alignment: Alignment.center,
                        height: controller.isPin.isTrue ? 45.h : 0,
                        child: renderFilterDataPrimary(context, controller)),
                    Container(),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: controller.scrollController.value,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            renderPoster(context, controller),
                            Visibility(
                                visible: controller.isPin.isFalse,
                                child: renderFilterData(context, controller)),
                            vendorList(context, controller),
                            controller.isLoadMore.isTrue
                                ? Container(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      child: Lottie.asset(AppPath.appLoading,
                                          frameRate: FrameRate.max),
                                      height: 30.h,
                                      width: 68.w,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )));
  }

  Widget renderMap(BuildContext context, VendorsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      margin: EdgeInsets.only(
          bottom: 5.h,
          top: controller.isMapExpanded.isTrue ? kDefaultPaddingWidget.h : 0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(defaultBorderRadius)),
            child: GestureDetector(
              onTap: () {
                controller.isMapExpanded.value =
                    !controller.isMapExpanded.value;
              },
              child: Obx(
                () => SizedBox(
                  height:
                      controller.isMapExpanded.value ? double.infinity : 200.h,
                  child: AbsorbPointer(
                    absorbing: controller.isMapExpanded.value ? false : true,
                    child: GoogleMapView(
                      // ignore: invalid_use_of_protected_member

                      listMarker: controller.listMarker.value,
                      onMapCreate: (GoogleMapController mapController) {
                        controller.mapController = mapController;
                        controller.changeCurrentLocationCamera();
                        controller.context = context;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 8.h,
              right: 8.w,
              child: Container(
                width: 32.w,
                height: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(32.r)),
                child: IconButton(
                  onPressed: () {
                    controller.isMapExpanded.value =
                        !controller.isMapExpanded.value;
                  },
                  icon: Icon(Icons.close_fullscreen_rounded,
                      size: 18.sp, color: Theme.of(context).iconTheme.color),
                ),
              )),
        ],
      ),
    );
  }

  vendorList(BuildContext context, VendorsController controller) {
    return controller.isLoading.isTrue
        ? const ListVendorShimmer()
        : Container(
            key: controller.dataKey,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
            margin: EdgeInsets.only(top: 6.h),
            child: controller.listSuggestedServices.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Text("Không tìm thấy kết quả", style: titleStyle))
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    controller: controller.vendorListController,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.listSuggestedServices.length,
                    itemBuilder: (context, index) {
                      final item = controller.listSuggestedServices[index];
                      return Hero(
                        tag:
                            "vendors-screen-${controller.listSuggestedServices[index].id}",
                        child: VendorItemPrimary(
                          // price: "300.000",
                          listType: "vendors-screen",
                          vendorInfo: item,
                        ),
                      );
                      // return GestureDetector(
                      //   onTap: () {
                      //     context.router.push(VendorsDetailPage(
                      //         first: item.id ?? '',
                      //         vendorsInfo: item,
                      //         last: item.category.getType().toString()));
                      //   },
                      //   child: VendorItemPrimary(
                      //     listType: "hot",
                      //     vendorInfo: item,
                      //   ),
                      //   //SmallVendorsCard(vendorInfo: item),
                      // );
                    }),
          );
  }

  Widget renderPoster(BuildContext context, VendorsController controller) {
    return Container(
      // height: 456.h,
      child: controller.isMapExpanded.isTrue
          ? Container(
              padding: EdgeInsets.zero,
              height: 456.h,
              child: renderMap(context, controller))
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.posterScrollController.value,
              child: Container(
                padding: EdgeInsets.only(top: kDefaultPaddingItem.h),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                width: double.infinity,
                child: controller.isLoadingPoster.isTrue
                    ? Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          child: Lottie.asset(AppPath.appLoading,
                              frameRate: FrameRate.max),
                          height: 68.h,
                          width: 100.w,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              renderSeachBar(context),
                              Container(
                                  padding: EdgeInsets.zero,
                                  height: 152,
                                  child: renderMap(context, controller)),
                              controller.listVariant.isNotEmpty
                                  ? renderListVariantCategory(context)
                                  : Container(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPaddingScreen.w),
                                margin: EdgeInsets.only(top: 10.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Đề xuất",
                                        style: titleStyle.copyWith(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            fontSize: 13.sp)),
                                  ],
                                ),
                              ),
                              renderRecommendVendors(context, controller),
                              Container(
                                  height: 152.h,
                                  child:
                                      renderCarouselSlide(context, controller)),
                            ],
                          )
                        ],
                      ),
              ),
            ),
    );
  }

  Widget renderSeachBar(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router
            .push(SearchPage(category: controller.category.value))
            .then((value) {
          Get.delete<SearchController>();
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
          margin: EdgeInsets.only(
              left: kDefaultPaddingScreen.w,
              right: kDefaultPaddingScreen.w,
              bottom: kDefaultPaddingItem.h),
          width: double.infinity,
          height: 30.h,
          decoration: BoxDecoration(
            // border: Border.all(color: darkGreyClr.withOpacity(.3), width: 1),
            color: ThemeServices().isDarkMode
                ? Colors.grey[600]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.zero,
                child: Icon(
                  Ionicons.search_outline,
                  color: Theme.of(context).primaryColor,
                  size: 18.sp,
                ),
              ),
              SizedBox(
                width: kDefaultPaddingItem.w,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 2.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tìm kiếm ...",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
                ),
              ))
              // Expanded(
              //   child: TextFormField(
              //     cursorColor: Theme.of(context).primaryColor,
              //     autofocus: false,
              //     // showCursor: false,
              //     // onChanged: (text) {
              //     //   if (text != "") {
              //     //     // searchController.handleSearchVendors(text);
              //     //   } else if (text == "") {
              //     //     // searchController.handleClearSearch();
              //     //   }
              //     // },
              //     // onFieldSubmitted: (text) {
              //     //   controller.handleSearchText();
              //     // },
              //     style: subTitleStyle,
              //     controller: controller.searchTextController.value,
              //     readOnly: true,
              //     decoration: const InputDecoration(
              //       border: InputBorder.none,
              //       hintText: 'Tìm kiếm ...',
              //     ),
              //   ),
              // ),
            ],
          )),
    );
  }

  Widget renderListVariantCategory(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            // bottom: 8.h,
            top: 10.h,
            left: kDefaultPaddingScreen.w,
            right: kDefaultPaddingScreen.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              child: Text("Danh mục",
                  style: titleStyle.copyWith(
                      color: Theme.of(context).backgroundColor,
                      fontSize: 13.sp)),
            ),
            GridView.builder(
              padding: EdgeInsets.only(top: kDefaultPaddingScreen.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                mainAxisSpacing: kDefaultPaddingScreen.w,
                crossAxisSpacing: kDefaultPaddingScreen.w,
              ),
              itemCount: controller.listVariant.length,
              itemBuilder: (context, index) {
                final VariantModel item = controller.listVariant[index];
                return InkWell(
                  onTap: () async {
                    // await controller.handleUpdateSelectedVariant(item);
                    context.router
                        .push(FilterVendorsPage(
                            isFilterByCity: false,
                            varient: item,
                            category: widget.category,
                            type:
                                '${widget.category!.display()} - ${item.name}'))
                        .then(
                            (value) => {Get.delete<FilterVendorsController>()});
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 50.w,
                            width: 50.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(item
                                            .image ??
                                        "https://travelgear.vn/blog/wp-content/uploads/2019/11/tôm-nướng-muoi.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            height: 20.h,
                            // child: AutoSizeText(
                            //   item.name,
                            //   textAlign: TextAlign.center,
                            //   maxLines: 2,
                            //   style: subTitleStyle.copyWith(
                            //       color: Theme.of(context).backgroundColor,
                            //       height: 1.3),
                            // ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.name,
                                style: subTitleStyle.copyWith(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).backgroundColor,
                                    height: 1.3),
                              ),
                            ),
                          )
                        ],
                      )),
                );
              },
            ),
          ],
        ));
  }

  Widget renderFilterData(BuildContext context, VendorsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPaddingScreen.w, vertical: kDefaultPaddingItem.h),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Obx(() => Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 0.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // renderCityPopup(context, controller),
                  Visibility(
                      visible: controller.listDistricts.isNotEmpty,
                      child: renderDistrictPopup(
                          context, controller, "popup-district")),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  renderPricePopUp(context, controller, "todo-tag-2"),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  Visibility(
                      visible: controller.listVariant.isNotEmpty,
                      child: renderVariantPopup(
                          context, controller, "popup-variant")),
                  // renderAttributePopup(context, controller),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  Visibility(
                      visible: controller.listTagline.isNotEmpty,
                      child: renderTaglinePopup(
                          context, controller, "popup-tagline")),
                ],
              ),
            ),
          )),
    );
  }

  Widget renderFilterDataPrimary(
      BuildContext context, VendorsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPaddingScreen.w, vertical: kDefaultPaddingItem.h),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Obx(() => Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: 0.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // renderCityPopup(context, controller),
                  Visibility(
                      visible: controller.listDistricts.isNotEmpty,
                      child: renderDistrictPopup(
                          context, controller, "popup-district-2")),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  renderPricePopUp(context, controller, "todo-tag-3"),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  Visibility(
                      visible: controller.listVariant.isNotEmpty,
                      child: renderVariantPopup(
                          context, controller, "popup-variant-2")),
                  // renderAttributePopup(context, controller),
                  SizedBox(
                    width: defaultPaddingItem.w,
                  ),
                  Visibility(
                      visible: controller.listTagline.isNotEmpty,
                      child: renderTaglinePopup(
                          context, controller, "popup-tagline-2")),
                ],
              ),
            ),
          )),
    );
  }

  Widget renderPricePopUp(
      BuildContext context, VendorsController controller, String tag) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(DialogAnimation(builder: Center(child: ,), settings: settings))
        Navigator.of(context).push(HeroDialogRoute(
          builder: (context) => Container(
            margin: EdgeInsets.only(
                top: AppBar().preferredSize.height +
                    kDefaultPaddingWidget.h * 3),
            alignment: Alignment.topCenter,
            child: TodoPopupPrice(
              onBack: (PriceRangeModel selectedPriceRange) {
                controller.handleUpdateSelectedPriceRange(selectedPriceRange);
              },
              heroTag: tag,
              prices: controller.selectedPriceRange.value,
              listPrices: controller.listPrice,
            ),
          ),
        ));
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: tag,
        child: Container(
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedPriceRange.value.title == ""
                        ? 0.5.w
                        : 1.w,
                    color: controller.selectedPriceRange.value.title != ""
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.selectedPriceRange.value.title == ""
                      ? "Giá"
                      : controller.selectedPriceRange.value.title,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight:
                          controller.selectedPriceRange.value.title != ""
                              ? FontWeight.w600
                              : FontWeight.w500,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : Colors.black54),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.caret_down_outline,
                    size: 12.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorPrimaryDark
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget renderAttributePopup(
      BuildContext context, VendorsController controller) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: TodoPopupAttribute(
                onBack: (List<AttributeModel> selectedAttributes) {
                  controller.handleUpdateListAttribute(selectedAttributes);
                },
                attributes: controller.listSelectedAttribute,
                listAttribute: controller.listAttribute,
              ),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: "popup-attribubte",
        child: Container(
            alignment: Alignment.center,
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.listSelectedAttribute.isNotEmpty
                        ? 1.w
                        : 0.5.w,
                    color: controller.listSelectedAttribute.isNotEmpty
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: controller.listSelectedAttribute.isNotEmpty
                        ? controller.listSelectedAttribute[0].name
                        : 'convenient'.tr,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: controller.listSelectedAttribute.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black54),
                    children: controller.listSelectedAttribute.length > 1
                        ? [
                            const TextSpan(text: ' +'),
                            TextSpan(
                                text:
                                    '${controller.listSelectedAttribute.length - 1}'),
                          ]
                        : [],
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.caret_down_outline,
                    size: 12.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorPrimaryDark
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget renderVariantPopup(
      BuildContext context, VendorsController controller, String tag) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: VariantPopup(
                onBack: (VariantModel selectedVarient) {
                  controller.handleUpdateSelectedVariant(selectedVarient);
                },
                heroTag: tag,
                listVariant: controller.listVariant,
                selectedVariant: controller.selectedVariant.value,
              ),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: tag,
        child: Container(
            alignment: Alignment.center,
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedVariant.value.name == ""
                        ? 0.5.w
                        : 1.w,
                    color: controller.selectedVariant.value.name == ""
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.selectedVariant.value.name == ""
                      ? "category2".tr
                      : controller.selectedVariant.value.name,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: controller.selectedVariant.value.name != ""
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : Colors.black54),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.caret_down_outline,
                    size: 12.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorPrimaryDark
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget renderTaglinePopup(
      BuildContext context, VendorsController controller, String tag) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: TaglinePopup(
                onBack: (TaglineModel selectedTaglines) {
                  controller.handleUpdateSelectedTaglines(selectedTaglines);
                },
                heroTag: tag,
                listTagline: controller.listTagline,
                selectedTagline: controller.selectedTaglines.value,
              ),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: tag,
        child: Container(
            alignment: Alignment.center,
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedTaglines.value.name == ""
                        ? 0.5.w
                        : 1.w,
                    color: controller.selectedTaglines.value.name == ""
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.selectedTaglines.value.name == ""
                      ? "tagline".tr
                      : controller.selectedTaglines.value.name,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: controller.selectedTaglines.value.name != ""
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : Colors.black54),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Icon(
                    Ionicons.caret_down_outline,
                    size: 12.sp,
                    color: ThemeServices().isDarkMode
                        ? kColorPrimaryDark
                        : HexColor(greyTextColor),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget renderDistrictPopup(
      BuildContext context, VendorsController controller, String tag) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: TodoPopupDistrict(
                heroTag: tag,
                onBack: (DistrictData selectedDistrict) {
                  controller.handleUpdateSelectedDistrict(selectedDistrict);
                },
                listDistrict: controller.listDistricts,
                selectedDistrict: controller.selectedDistrics.value,
              ),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: tag,
        child: Container(
            alignment: Alignment.center,
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedDistrics.value.name == null
                        ? 0.5.w
                        : 1.w,
                    color: controller.selectedDistrics.value.name != null
                        ? ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : Colors.black
                        : ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor)),
                borderRadius: BorderRadius.circular(defaultBorderRadiusItem)),
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  controller.selectedDistrics.value.name == null
                      ? "district".tr
                      : controller.selectedDistrics.value.name ?? "",
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: controller.selectedDistrics.value.name == null
                          ? FontWeight.w500
                          : FontWeight.w600,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : Colors.black54),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Visibility(
                    visible: !controller.isVisible.value,
                    child: SizedBox(
                      width: 26.w,
                    )),
                Visibility(
                    visible: controller.isVisible.value,
                    child: Icon(
                      Ionicons.caret_down_outline,
                      size: 12.sp,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : HexColor(greyTextColor),
                    ))
              ],
            )),
      ),
    );
  }

  Widget renderCarouselSlide(
      BuildContext context, VendorsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      margin: EdgeInsets.only(bottom: 5.h),
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 5 / 2,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            reverse: false,
            autoPlay: controller.isAutoSwipper.value,
            //autoPlayCurve: Curves.easeInOutCubicEmphasized,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(seconds: 2),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, resson) {
              // controller.handleUpdateCarouselIndex(index);
              controller.carouselIndex.value = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.height),
        items: controller.listBanners.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  context.router.push(
                    VendorsDetailPage(
                        first: item.vendor!.id ?? "",
                        last: item.vendor!.category.getType(),
                        tagId: "banner-${item.vendor!.id}",
                        imageUrl: item.vendor!.thumbnail?.path ?? "",
                        vendorTitle: item.vendor!.brandName,
                        vendorsInfo: item.vendor!,
                        voucher: null),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width + 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(item
                              .image), //CachedNetworkImageProvider(item.image),
                          fit: BoxFit.fill)),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget renderRecommendVendors(
      BuildContext context, VendorsController controller) {
    return Container(
      height: 130.h,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(top: 6.h, bottom: 5.h),
      child: Container(
        padding: EdgeInsets.only(left: kDefaultPaddingScreen.w),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: controller.listRecommendVendors.length,
          itemBuilder: (ctx, index) {
            return Container(
              padding: EdgeInsets.only(left: index > 0 ? 5.w : 0),
              child: Hero(
                tag:
                    "vendorByCategory-${controller.listRecommendVendors[index].id}",
                child: VendorsItemThird(
                    listType: "vendorByCategory",
                    vendorInfo: controller.listRecommendVendors[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
