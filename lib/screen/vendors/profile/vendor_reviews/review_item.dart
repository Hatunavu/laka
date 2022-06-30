import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/review/review_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_reviews/vendors_reviews_controller.dart';
import 'package:client_tggt/shared/widget/dialog/dialog_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:auto_route/auto_route.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key, required this.item, required this.controller})
      : super(key: key);
  final ReviewModel item;
  final VendorsReviewController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: kDefaultPaddingWidget.h, top: kDefaultPaddingWidget.h),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.3.w, color: Colors.grey))),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: item.urlUserAvatar,
                          memCacheHeight: 200,
                          imageBuilder: (context, image) => CircleAvatar(
                            backgroundImage: image,
                            radius: 25,
                          ),
                        ),
                        SizedBox(
                          width: kDefaultPaddingWidget.w,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.reviewerName,
                                    style: subTitleStyle.copyWith(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: kDefaultPaddingItem.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.only(bottom: 1.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultBorderRadius.r)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 3.h),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                item.getProductName,
                                                style: subTitleStyle.copyWith(
                                                    fontSize: 11.sp,
                                                    color: kColorPrimaryLight),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 12.h,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                            padding: const EdgeInsets.all(0),
                                            child: Icon(Icons.star,
                                                color: index <
                                                        (item.rating).toInt()
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .secondaryVariant,
                                                size: 12.sp));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                  padding: EdgeInsets.zero,
                                  child: GestureDetector(
                                    onTap: () {
                                      context.router
                                          .push(BookingDetailPage(
                                        bookingId: item.order!.id,
                                        parentPage: "booking_list",
                                      ))
                                          .then((value) {
                                        Get.delete<BookingDetailController>();
                                      });
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Mã lịch: ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: item.order!.orderId,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ])
                      ],
                    ),
                    item.response != null
                        ? Container()
                        : controller.isLoadingReply.value == true
                            ? Container(
                                padding: EdgeInsets.zero,
                                width: 68.w,
                                height: 30.h,
                                child: Lottie.asset(AppPath.appLoading,
                                    frameRate: FrameRate.max),
                              )
                            : GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext dialogContext) {
                                      return DialogTextField(
                                        context: context,
                                        controller: controller
                                            .replyTextController.value,
                                        hint: "Trả lời bình luận",
                                        title: 'Trả lời',
                                        minLines: 1,
                                        confirmTitlel: "Xác nhận",
                                        onConfirm: () {
                                          // controller.handleUpdateVendorProfile();
                                          controller
                                              .handleCreateReply(item.id ?? "");
                                          Navigator.pop(context);
                                        },
                                        onDismiss: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: kDefaultPaddingItem.w),
                                    child: Icon(
                                      Ionicons.arrow_undo_outline,
                                      size: 22.sp,
                                    ),
                                  ),
                                ),
                              )
                  ],
                ),
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.content ?? "",
                    style: subTitleStyle.copyWith(
                      color: Colors.black,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Visibility(
                    visible: item.listGallery.isNotEmpty,
                    child: renderListGallery(context, item.listGallery)),
                SizedBox(
                  height: kDefaultPaddingItem.h,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.zero,
                  child: Text(item.reviewTime),
                )
              ],
            ),
          ),
          item.response != null ? renderReplyInfo(context, item) : Container()
        ],
      ),
    );
  }
}

Widget renderListGallery(BuildContext context, List<GalleryModel> galleries) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.zero,
    height: 86.h,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: galleries.length,
      itemBuilder: (ctx, index) {
        final GalleryModel item = galleries[index];
        return InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(right: 10.w),
            width: 86.w,
            height: 86.w,
            child: CachedNetworkImage(
              imageUrl: item.path ?? "",
              fit: BoxFit.cover,
              memCacheHeight: 200,
            ),
          ),
        );
      },
    ),
  );
}

Widget renderReplyInfo(BuildContext context, ReviewModel item) {
  return Container(
    padding: EdgeInsets.all(kDefaultPaddingItem.w),
    decoration: BoxDecoration(color: Colors.grey[100]),
    margin: EdgeInsets.only(left: kDefaultPaddingItem.w),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
              text: 'Phản hồi từ: ',
              style: titleStyle.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: item.response!.by.profile!.fullName)
              ],
            ),
          ),
        ),
        SizedBox(
          height: kDefaultPaddingItem.h,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            item.response!.content,
            style: subTitleStyle.copyWith(
              color: Colors.black,
              fontSize: 15.sp,
            ),
          ),
        ),
      ],
    ),
  );
}
