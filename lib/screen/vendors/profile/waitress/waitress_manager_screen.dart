import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/profile/waitress/add_waitress_controller.dart';
import 'package:client_tggt/screen/vendors/profile/waitress/waitress_manager_controller.dart';
import 'package:client_tggt/screen/vendors/profile/waitress/widget/vendor_staff_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';

class WaitressManagerScreen extends StatelessWidget {
  const WaitressManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WaitressManagerController controller =
        Get.put(WaitressManagerController(getIt.get<ApiClient>()));
    return BaseScreen(
        title: "Kỹ thuật viên",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
              color: Theme.of(context).iconTheme.color,
            )),
        trailing: [
          GestureDetector(
            onTap: () {
              context.router.push(AddWaitressPage(onBack: (StaffModel item) {
                controller.listStaff.insert(0, item);
              })).then((value) => {Get.delete<AddWaitressController>()});
            },
            child: Container(
              padding: EdgeInsets.zero,
              child: Icon(
                Ionicons.add_outline,
                size: 23.sp,
                color: kColorPrimaryLight,
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPaddingScreen.w,
          )
        ],
        child: Obx(
          () => controller.isLoading.isTrue
              ? const LoadingScreen()
              : renderBody(context, controller),
        ));
  }
}

Widget renderBody(BuildContext context, WaitressManagerController controller) {
  if (controller.listStaff.isEmpty) {
    return Container(
      alignment: Alignment.center,
      child: Text("Cơ sở của bạn chưa có kỹ thuật viên nào!",
          style: titleStyle.copyWith(height: 1.3), textAlign: TextAlign.center),
    );
  } else {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPaddingScreen.w,
          vertical: kDefaultPaddingWidget.h),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.listStaff.length,
          itemBuilder: (ctx, index) {
            return VendorStaffItem(item: controller.listStaff[index]);
          }),
    );
  }
}
