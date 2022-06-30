import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/screen/vendors/booking/create_order/widget/vendor_product_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

class VendorListProductScreen extends StatefulWidget {
  VendorListProductScreen(
      {Key? key, required this.listProduct, this.selectedProduct, this.onBack})
      : super(key: key);
  final List<ServicesModel> listProduct;
  final ServicesModel? selectedProduct;
  final Function(ServicesModel item)? onBack;

  @override
  State<VendorListProductScreen> createState() =>
      _VendorListProductScreenState();
}

class _VendorListProductScreenState extends State<VendorListProductScreen> {
  final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

  var selectedProduct = ServicesModel();
  @override
  void initState() {
    super.initState();
    if (widget.selectedProduct != null) {
      selectedProduct = widget.selectedProduct!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "listService".tr,
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
              size: 23.sp,
              color: Colors.black,
            )),
        child: Container(
            margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      // ignore: invalid_use_of_protected_member
                      itemCount: widget.listProduct.length,
                      itemBuilder: (context, int index) {
                        final ServicesModel item =
                            // ignore: invalid_use_of_protected_member
                            widget.listProduct[index];
                        return Container(
                          padding: EdgeInsets.zero,
                          margin:
                              EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: VendorProductItem(
                                item: item,
                              )),
                              SizedBox(
                                width: kDefaultPaddingWidget.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedProduct = item;
                                  });
                                },
                                child: Container(
                                  width: 18.w,
                                  height: 18.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9.r),
                                      border: Border.all(
                                          width: 0.6.w,
                                          color: item.id != selectedProduct.id
                                              ? Colors.grey
                                              : kColorPrimaryLight)),
                                  child: selectedProduct.id == item.id
                                      ? Container(
                                          width: 8.w,
                                          height: 8.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                              color: kColorPrimaryLight),
                                        )
                                      : Container(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Container(),
                Visibility(
                    visible: selectedProduct.id != null,
                    child: Container(
                      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
                      child: InkwellButtonLoading(
                          label: "confirm".tr,
                          onPressed: () {
                            widget.onBack?.call(selectedProduct);
                            Navigator.of(context).pop();
                          }),
                    ))
              ],
            )));
  }
}
