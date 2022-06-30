import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/review/enum_review_type.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_reviews/review_item.dart';
import 'package:client_tggt/screen/vendors/profile/vendor_reviews/vendors_reviews_controller.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class VendorsReviewsScreen extends StatelessWidget {
  const VendorsReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final VendorsReviewController controller =
        Get.put(VendorsReviewController(getIt.get<ApiClient>()));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: const Icon(
                Ionicons.chevron_back_outline,
                size: 23,
                color: Colors.black,
              )),
          actions: [
            InkWell(
                onTap: () {},
                child: const Icon(
                  Ionicons.search_outline,
                  size: 26,
                  color: Colors.black,
                )),
            SizedBox(
              width: kDefaultPaddingScreen.w,
            )
          ],
          shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.3.w)),
        ),
        body: Obx(
          () => SafeArea(
              child: controller.isLoading.isTrue
                  ? const LoadingScreen()
                  : Container(
                      padding: EdgeInsets.symmetric(
                          vertical: kDefaultPaddingWidget.h,
                          horizontal: kDefaultPaddingScreen.w),
                      child: Column(
                        children: [
                          renderRattingInfo(context, controller),
                          SizedBox(
                            height: kDefaultPaddingItem.h,
                          ),
                          renderListReviews(context, controller),
                          // Visibility(
                          //     child:
                          //         Text(controller.reviewType.value.display()))
                        ],
                      ))),
        ));
  }
}

Widget renderRattingInfo(
    BuildContext context, VendorsReviewController controller) {
  return Container(
    padding: EdgeInsets.zero,
    child: Column(
      children: [
        Row(
          children: List.generate(
              controller.listReviewType.length,
              (index) => Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.handleChangeReviewType(stringToReviewType(
                            controller.listReviewType[index]));
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPaddingWidget - 3.w),
                          margin: EdgeInsets.symmetric(
                              horizontal: kDefaultPaddingItem.w * 0.3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                  width: controller.reviewType.value.display() ==
                                          controller.listReviewType[index]
                                      ? 0.5
                                      : 0,
                                  color: controller.reviewType.value.display() ==
                                          controller.listReviewType[index]
                                      ? kColorPrimaryLight
                                      : Colors.transparent),
                              color: controller.reviewType.value.display() ==
                                      controller.listReviewType[index]
                                  ? Colors.transparent
                                  : Colors.grey[200]),
                          child: Text(controller.listReviewType[index],
                              style: TextStyle(fontSize: 12.sp))),
                    ),
                  )),
        ),
        SizedBox(height: kDefaultPaddingItem.h - 2.h),
        Row(
          children: List.generate(
              controller.listReivewRating.length,
              (index) => Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.handleChangeReviewType(stringToReviewType(
                            controller.listReivewRating[index]));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: kDefaultPaddingItem.h - 3.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: kDefaultPaddingItem.w * 0.3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            border: Border.all(
                                width: controller.reviewType.value.display() ==
                                        controller.listReivewRating[index]
                                    ? 0.5
                                    : 0,
                                color: controller.reviewType.value.display() ==
                                        controller.listReivewRating[index]
                                    ? kColorPrimaryLight
                                    : Colors.transparent),
                            color: controller.reviewType.value.display() ==
                                    controller.listReivewRating[index]
                                ? Colors.transparent
                                : Colors.grey[200]),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 15.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (ctx, index2) {
                                  return index2 <
                                          int.parse(controller
                                              .listReivewRating[index])
                                      ? Container(
                                          padding: const EdgeInsets.all(0),
                                          child: Icon(Icons.star,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 10.sp))
                                      : Container();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            getRatingCount(context,
                                controller.listReivewRating[index], controller)
                          ],
                        ),
                      ),
                    ),
                  )),
        ),
      ],
    ),
  );
}

Widget renderListReviews(
    BuildContext context, VendorsReviewController controller) {
  return Expanded(
    child: controller.isFilterLoading.isTrue
        ? Container(
            alignment: Alignment.center,
            child: SizedBox(
              child: Lottie.asset(AppPath.appLoading, frameRate: FrameRate.max),
              height: 68.h,
              width: 100.w,
            ))
        : Container(
            padding: EdgeInsets.zero,
            child: controller.listReviews.isEmpty
                ? renderEmptyReviews(context)
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.listReviews.length,
                            itemBuilder: (context, index) {
                              final item = controller.listReviews[index];
                              return ReviewItem(
                                  item: item, controller: controller);
                            }),
                      ),
                      Visibility(
                          visible: controller.listReviews.isNotEmpty &&
                              controller.listReviews.length ==
                                  controller.totalPage.value,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPaddingWidget.w * 2),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(
                                      right: kDefaultPaddingWidget.w),
                                  height: 1.w,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                )),
                                Text(
                                  "Hết",
                                  style: subTitleStyle,
                                ),
                                Expanded(
                                    child: Container(
                                  height: 1.w,
                                  margin: EdgeInsets.only(
                                      left: kDefaultPaddingWidget.w),
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                )),
                              ],
                            ),
                          ))
                    ],
                  )),
  );
}

Widget renderEmptyReviews(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.zero,
    child: Text(
      "Chưa có đánh giá",
      textAlign: TextAlign.center,
      style: titleStyle.copyWith(height: 1.5),
    ),
  );
}

Widget getRatingCount(
    BuildContext context, String type, VendorsReviewController controller) {
  if (type == ReviewType.star_1.display()) {
    return Text('(${controller.ratingInfo.value.star_1})',
        style: TextStyle(fontSize: 10.sp, color: Colors.grey));
  }
  if (type == ReviewType.star_2.display()) {
    return Text('(${controller.ratingInfo.value.star_2})',
        style: TextStyle(fontSize: 10.sp, color: Colors.grey));
  }
  if (type == ReviewType.star_3.display()) {
    return Text('(${controller.ratingInfo.value.star_3})',
        style: TextStyle(fontSize: 10.sp, color: Colors.grey));
  }
  if (type == ReviewType.star_4.display()) {
    return Text('(${controller.ratingInfo.value.star_4})',
        style: TextStyle(fontSize: 10.sp, color: Colors.grey));
  }
  if (type == ReviewType.star_5.display()) {
    return Text('(${controller.ratingInfo.value.star_5})',
        style: TextStyle(fontSize: 10.sp, color: Colors.grey));
  } else {
    return const Text("0");
  }
}
