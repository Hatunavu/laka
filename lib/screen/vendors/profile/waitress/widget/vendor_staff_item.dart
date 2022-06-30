import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorStaffItem extends StatelessWidget {
  const VendorStaffItem({Key? key, required this.item}) : super(key: key);
  final StaffModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 3.h, top: kDefaultPaddingItem.h),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3.w, color: Colors.grey))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: item.image,
                memCacheHeight: 200,
                imageBuilder: (context, image) => CircleAvatar(
                  backgroundImage: image,
                  radius: 20.sp,
                ),
              ),
              SizedBox(
                width: kDefaultPaddingItem.w,
              ),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.only(top: 3.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.name,
                          style: titleStyle.copyWith(
                              fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.zero,
                        child: Text(
                          item.description ?? "",
                          style: subTitleStyle.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ]),
              )
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Trạng thái hoạt động: ',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                Container(
                  margin: EdgeInsets.only(right: kDefaultPaddingWidget.h),
                  child: Switch(
                      value: item.status == "publish",
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                        // item.status == "publish"
                        //     ? productController.handleUpdateStatus(
                        //         serviceItem.id!, false)
                        //     : productController.handleUpdateStatus(
                        //         serviceItem.id!, true);
                      }),
                )
              ]),
        ],
      ),
    );
  }
}
