import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/screen/profile/message/staff/customer_staff_controller.dart';
import 'package:client_tggt/screen/profile/message/staff/widget/customer_staff_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StaffScreen extends StatefulWidget {
  StaffScreen(
      {Key? key, required this.vendorId, required this.orderId, this.onBack})
      : super(key: key);
  final String vendorId;
  final String orderId;
  final Function(List<StaffModel> item)? onBack;
  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final CustomerStaffController controller =
      Get.put(CustomerStaffController(getIt.get<ApiClient>()));

  @override
  void initState() {
    super.initState();
    controller.orderId.value = widget.orderId;
    controller.getListStaff(widget.vendorId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "technician".tr,
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
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingScreen.w,
              vertical: kDefaultPaddingWidget.h),
          child: Obx(() => controller.isLoading.isTrue
              ? const LoadingScreen()
              : renderBody(context, controller)),
        ));
  }

  Widget renderBody(BuildContext context, CustomerStaffController controller) {
    if (controller.listStaff.isEmpty) {
      return Container(
        alignment: Alignment.center,
        child: Text("vendorNotHaveTech".tr,
            style: titleStyle.copyWith(height: 1.3),
            textAlign: TextAlign.center),
      );
    } else {
      return Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.listStaff.length,
                  itemBuilder: (ctx, index) {
                    final item = controller.listStaff[index];
                    final bool isSelected =
                        controller.listSelectedStaff.contains(item);
                    return CustomerStaffItem(
                      item: item,
                      isSelected: isSelected,
                      onSelect: () {
                        if (controller.listSelectedStaff.contains(item)) {
                          controller.listSelectedStaff.remove(item);
                        } else {
                          controller.listSelectedStaff.add(item);
                        }
                      },
                    );
                  }),
            ),
            Visibility(
                visible: controller.listSelectedStaff.isNotEmpty,
                child: renderBottom(context, controller))
          ],
        ),
      );
    }
  }

  Widget renderBottom(
      BuildContext context, CustomerStaffController controller) {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPaddingScreen.w,
          vertical: kDefaultPaddingWidget.h),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5.h))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(children: [
            Column(
              children: [
                Text(
                  "extraCharge".tr,
                  style: titleStyle,
                ),
                SizedBox(
                  height: kDefaultPaddingItem.h,
                ),
                Text(
                  currencyFormatter
                      .format(controller.listSelectedStaff.length * 500000),
                  style: subTitleStyle,
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Container(
              color: Colors.black,
            )
          ]),
          InkwellButtonLoading(
              label: "confirm".tr,
              isLoading: controller.isLoadingConfirm.value,
              onPressed: () async {
                // context.router.push(const SignupVendorThirdPage());
                final bool status =
                    await controller.handleUpdateStaffForOrder();
                if (status == true) {
                  await widget.onBack?.call(controller.listSelectedStaff);
                  context.router.pop();
                } else {}
              })
        ],
      ),
    );
  }
}
