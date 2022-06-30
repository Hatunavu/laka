import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/filter/price_range_model.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/screen/filter_vendors/filter_vendors_controller.dart';
import 'package:client_tggt/screen/filter_vendors/widget/attribute_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/category_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/city_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/district_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/filter_vendors_shimmer_loading.dart';
import 'package:client_tggt/screen/filter_vendors/widget/price_popup.dart';
import 'package:client_tggt/screen/filter_vendors/widget/variant_popup.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/search/widget/vendor_item_primary.dart';
import 'package:client_tggt/screen/vendors_list/widgets/list_vendors_primary_shimmer.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/popup_card/custom_rect_tween.dart';
import 'package:client_tggt/shared/widget/popup_card/hero_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:indexed/indexed.dart';

class FilterVendorsScreen extends StatefulWidget {
  FilterVendorsScreen(
      {Key? key,
      this.type,
      required this.isFilterByCity,
      this.cityCode,
      this.voucher,
      this.varient,
      this.category})
      : super(key: key);
  final String? type;
  final bool isFilterByCity;
  final String? cityCode;
  final VoucherModel? voucher;
  final VariantModel? varient;
  final CategoryType? category;
  @override
  State<FilterVendorsScreen> createState() => _FilterVendorsScreenState();
}

class _FilterVendorsScreenState extends State<FilterVendorsScreen> {
  final FilterVendorsController controller =
      Get.put(FilterVendorsController(getIt.get<ApiClient>()));
  @override
  void initState() {
    final MainController mainController = Get.find();
    // controller.handleGetListVendorByCategory(widget.isFilterByCity == true
    //     ? widget.cityCode ?? mainController.currentCityCode.value
    //     : "01");
    if (widget.category != null) {
      controller.handleUpdateDefaultCategory(widget.category!);
    }
    if (widget.isFilterByCity == true && widget.cityCode != "") {
      controller.handleUpdateCityCode(widget.cityCode ?? "");
      controller.handleGetListVendorByCategory(
          widget.cityCode ?? "01", widget.varient);
    } else {
      controller.handleUpdateCityCode(mainController.currentCityCode.value);
      controller.handleGetListVendorByCategory(
          mainController.currentCityCode.value, widget.varient);
    }
    Future.wait([
      controller.getListDistrictByProvinceID(widget.isFilterByCity == true
          ? widget.cityCode ?? mainController.currentCityCode.value
          : "01"),
      controller.getListSubCategory(widget.category)
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1;

    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Container(
          padding: EdgeInsets.only(
              top: kDefaultPaddingWidget.h,
              left: kDefaultPaddingScreen.w,
              right: kDefaultPaddingScreen.w,
              bottom: kDefaultPaddingWidget.h),
          child: Column(
            children: [
              renderHeader(context, widget.type ?? "", controller),
              Obx(() => Indexed(
                    index: 10,
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        //padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: Theme.of(context).backgroundColor,
                        alignment: Alignment.center,
                        height: controller.isVisible.value ? 45.h : 0,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Visibility(
                                //     visible: widget.isFilterByCity == false &&
                                //         controller.listProvinces.isNotEmpty,
                                //     child:
                                //         renderCityPopup(context, controller)),
                                Visibility(
                                    visible:
                                        controller.listDistricts.isNotEmpty,
                                    child: renderDistrictPopup(
                                        context, controller)),
                                Visibility(
                                    visible: widget.varient == null,
                                    child: renderCategory(context, controller)),
                                SizedBox(
                                  width: defaultPaddingItem.w,
                                ),
                                renderPricePopUp(context, controller),
                                SizedBox(
                                  width: defaultPaddingItem.w,
                                ),
                                Visibility(
                                    visible:
                                        controller.listAttribute.isNotEmpty,
                                    child: renderAttributePopup(
                                        context, controller)),
                                SizedBox(
                                  width: defaultPaddingItem.w,
                                ),
                                Visibility(
                                    visible:
                                        controller.listVariant.isNotEmpty &&
                                            widget.varient == null,
                                    child: renderVariantPopup(context)),
                                SizedBox(
                                  width: defaultPaddingItem.w,
                                ),
                              ],
                            ),
                          ),
                        )),
                  )),
              SizedBox(
                height: 0.h,
              ),
              Obx(() => Visibility(
                  visible: controller.isEmptyResult.value,
                  child: Text('noVendor'.tr))),
              Obx(() => Expanded(
                  child: controller.isLoading.value == true
                      ? const ListVendorPrimaryShimmer()
                      : ListView.builder(
                          shrinkWrap: true,
                          controller: controller.controller,
                          padding: EdgeInsets.zero,
                          // ignore: invalid_use_of_protected_member
                          itemCount: controller.listVendors.value.length,
                          itemBuilder: (context, int index) {
                            final VendorModel item =
                                // ignore: invalid_use_of_protected_member
                                controller.listVendors.value[index];
                            // return Hero(
                            //     tag:
                            //         "filter-${controller.listVendors[index].id}",
                            //     child: VendorItem(
                            //       price: "300.000",
                            //       listType: "filter",
                            //       vendorInfo: item,
                            //       paddingBottom: kDefaultPaddingWidget.h * 1.5,
                            //       voucher: widget.voucher,
                            //     ));
                            return Hero(
                              tag: "filter-${controller.listVendors[index].id}",
                              child: VendorItemPrimary(
                                // price: "300.000",
                                listType: "filter",
                                vendorInfo: item,
                              ),
                            );
                          })))
            ],
          )),
    );
  }

  Widget renderPricePopUp(
      BuildContext context, FilterVendorsController controller) {
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
              heroTag: "todo-tag-2",
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
        tag: "todo-tag-2",
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
                      ? "price".tr
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
                Visibility(
                    visible: !controller.isVisible.value,
                    child: const SizedBox(
                      width: 26,
                    )),
                Visibility(
                    visible: controller.isVisible.value,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Icon(
                        Ionicons.caret_down_outline,
                        size: 12.sp,
                        color: ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor),
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  Widget renderCategory(
      BuildContext context, FilterVendorsController controller) {
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPaddingItem.w,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: TodoPopupVendorType(
                onBack: (List<CategoryType> listCategory) {
                  controller.handleUpdateListSelectedCategory(listCategory);
                },
                categories: controller.selectedCategory,
                listCategory: controller.listCategory,
              ),
            ),
          ));
        },
        child: Hero(
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          tag: "popup-type",
          child: Container(
              height: 25.h,
              decoration: BoxDecoration(
                  border: Border.all(
                      width:
                          controller.selectedCategory.isNotEmpty ? 1.w : 0.5.w,
                      color: controller.selectedCategory.isNotEmpty
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
                  RichText(
                    text: TextSpan(
                      text: controller.selectedCategory.isNotEmpty
                          ? controller.selectedCategory[0].getType()
                          : "category2".tr,
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: controller.selectedCategory.isNotEmpty
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: ThemeServices().isDarkMode
                              ? kColorPrimaryDark
                              : Colors.black54),
                      children: controller.selectedCategory.length > 1
                          ? [
                              const TextSpan(text: ' +'),
                              TextSpan(
                                  text:
                                      '${controller.selectedCategory.length - 1}'),
                            ]
                          : [],
                    ),
                  ),
                  SizedBox(
                    width: 6.h,
                  ),
                  Visibility(
                      visible: !controller.isVisible.value,
                      child: const SizedBox(
                        width: 26,
                      )),
                  Visibility(
                      visible: controller.isVisible.value,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: Icon(
                          Ionicons.caret_down_outline,
                          size: 12.sp,
                          color: ThemeServices().isDarkMode
                              ? kColorPrimaryDark
                              : HexColor(greyTextColor),
                        ),
                      ))
                ],
              )),
        ),
      ),
    );
  }

  Widget renderAttributePopup(
      BuildContext context, FilterVendorsController controller) {
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
                Visibility(
                    visible: !controller.isVisible.value,
                    child: SizedBox(
                      width: 26.w,
                    )),
                Visibility(
                    visible: controller.isVisible.value,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      child: Icon(
                        Ionicons.caret_down_outline,
                        size: 12.sp,
                        color: ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : HexColor(greyTextColor),
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  Widget renderVariantPopup(BuildContext context) {
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
                heroTag: "popup-variant",
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
        tag: "popup-variant",
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

  Widget renderCityPopup(
      BuildContext context, FilterVendorsController controller) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Container(
              margin: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      kDefaultPaddingWidget.h * 3),
              alignment: Alignment.topCenter,
              child: TodoPopupCity(
                onBack: (ProvinceData selectedProvince) {
                  controller.handleUpdateSelectedProvince(selectedProvince);
                },
                listProvince: controller.listProvinces,
                selectedProvince: controller.selectedProvince.value,
              ),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: "popup-city",
        child: Container(
            alignment: Alignment.center,
            height: 25.h,
            decoration: BoxDecoration(
                border: Border.all(
                    width: controller.selectedProvince.value.name == null
                        ? 0.5.w
                        : 1.w,
                    color: controller.selectedProvince.value.name == null
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
                  controller.selectedProvince.value.name == null
                      ? "province".tr
                      : controller.selectedProvince.value.name ?? "",
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: controller.selectedProvince.value.name != null
                          ? FontWeight.w600
                          : FontWeight.w500,
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

  Widget renderDistrictPopup(
      BuildContext context, FilterVendorsController controller) {
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
                onBack: (DistrictData selectedDistrict) {
                  controller.handleUpdateSelectedDistrict(selectedDistrict);
                },
                heroTag: "popup-district",
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
        tag: "popup-district",
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

  Widget renderListVendor(
      BuildContext context, FilterVendorsController controller) {
    return Obx(() => Expanded(
        child: controller.isLoading.value == true
            ? const FilterVendorsShimmerLoading()
            : ListView.builder(
                shrinkWrap: true,
                controller: controller.controller,
                padding: EdgeInsets.zero,
                // ignore: invalid_use_of_protected_member
                itemCount: controller.listVendors.value.length,
                itemBuilder: (context, int index) {
                  final VendorModel item =
                      // ignore: invalid_use_of_protected_member
                      controller.listVendors.value[index];
                  return Hero(
                      tag: "filter-${controller.listVendors[index].id}",
                      child: VendorItem(
                        price: "300.000",
                        listType: "filter",
                        vendorInfo: item,
                        paddingBottom: kDefaultPaddingWidget.h * 1.5,
                      ));
                })));
  }

  Widget renderHeader(
      BuildContext context, String title, FilterVendorsController controller) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(Ionicons.chevron_back_outline,
                size: 23.sp,
                color: ThemeServices().isDarkMode
                    ? kColorGreyDark
                    : Colors.black54),
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPaddingWidget.w * 2.5, vertical: 7.h),
              decoration: BoxDecoration(
                  color: ThemeServices().isDarkMode
                      ? kColorTextLight
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(defaultBorderRadius.r)),
              child: RichText(
                text: TextSpan(
                  text: title,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: ThemeServices().isDarkMode
                          ? kColorPrimaryDark
                          : Colors.black54),
                  children: const <TextSpan>[],
                ),
              )),
          GestureDetector(
            onTap: () {
              // showMaterialModalBottomSheet(
              //   backgroundColor: Colors.transparent,
              //   context: context,
              //   expand: false,
              //   builder: (context) => Container(
              //     padding: EdgeInsets.zero,
              //     decoration: BoxDecoration(
              //         color: Theme.of(context).backgroundColor,
              //         borderRadius:
              //             BorderRadius.circular(defaultBorderRadius.r)),
              //     height: MediaQuery.of(context).size.height * .93,
              //     child: SingleChildScrollView(
              //       child: Column(
              //         children: const [
              //           Text("123"),
              //         ],
              //       ),
              //     ),
              //   ),
              // );
            },
            child: Icon(
              Ionicons.options_outline,
              size: 23,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
