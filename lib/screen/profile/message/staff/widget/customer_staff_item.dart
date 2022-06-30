import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class CustomerStaffItem extends StatelessWidget {
  const CustomerStaffItem(
      {Key? key,
      required this.item,
      required this.isSelected,
      this.onSelect,
      this.isVendorDetail = false})
      : super(key: key);
  final StaffModel item;
  final bool isSelected;
  final Function? onSelect;
  final bool? isVendorDetail;
  @override
  Widget build(BuildContext context) {
    final imageStaff = [
      GalleryModel(
          path: item.image, type: "image", pathUrl: item.image, id: "0")
    ];
    return Container(
      padding: EdgeInsets.only(bottom: 6.h, top: 6.h),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3.w, color: Colors.grey))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  context.router
                      .push(VendorsGalleryDetailPage(
                          index: 0, listImage: imageStaff))
                      .then((value) {
                    Get.delete<VendorsGalleryDetailController>();
                  });
                  ;
                },
                child: CachedNetworkImage(
                  imageUrl: item.image,
                  memCacheHeight: 200,
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 23.sp,
                  ),
                ),
              ),
              SizedBox(
                width: kDefaultPaddingWidget.w,
              ),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.only(top: 3.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                          visible: item.description == "",
                          child: SizedBox(
                            height: kDefaultPaddingItem.h,
                          )),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.name,
                          style: titleStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                      ),
                      Visibility(
                        visible: item.description != "",
                        child: SizedBox(
                          height: 6.h,
                        ),
                      ),
                      Visibility(
                        visible: item.description != "",
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                          child: Text(
                            item.description ?? "",
                            style: subTitleStyle.copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          ),
          Visibility(
            visible: isVendorDetail == false,
            child: GestureDetector(
              onTap: () {
                onSelect?.call();
              },
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    border: Border.all(
                        width: 0.6,
                        color: isSelected
                            ? ThemeServices().isDarkMode
                                ? kColorPrimaryDark
                                : kColorPrimaryLight
                            : ThemeServices().isDarkMode
                                ? kColorTextGrey
                                : Colors.black)),
                child: isSelected
                    ? Icon(
                        Ionicons.checkmark_outline,
                        size: 16,
                        color: ThemeServices().isDarkMode
                            ? kColorPrimaryDark
                            : kColorPrimaryLight,
                      )
                    : Container(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
