import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/review/list_review_response/doc.dart';
import 'package:client_tggt/screen/review/review_controller.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/rating_bar.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/review_card_primary.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key, this.vendorID = ''}) : super(key: key);

  final String vendorID;

  @override
  Widget build(BuildContext context) {
    ReviewController controller =
        Get.put(ReviewController(getIt.get<ApiClient>()));
    controller.vendorId = vendorID;
    controller.refreshController = RefreshController(initialRefresh: false);
    controller.onRefresh();
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
            onPressed: () {
              // controller.refreshController.dispose();
              context.router.pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Theme.of(context).iconTheme.color),
        title: 'review'.tr,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPaddingWidget),
          child: Column(
            children: [
              buildRating(),
              buildDivider(kDefaultPaddingItem.h),
              Expanded(child: buildListReview(controller)),
            ],
          ),
        ));
  }

  Column buildDivider(double padding) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: padding),
          child: Divider(
            indent: kDefaultPadding.w,
            endIndent: kDefaultPadding.w,
          ),
        ),
      ],
    );
  }

  Widget buildListReview(ReviewController controller) {
    return Obx(
      () => ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        primary: false,
        // shrinkWrap: true,
        itemCount: controller.listReview.value.docs?.length ?? 0,
        itemBuilder: (context, index) {
          final review = controller.listReview.value.docs?[index] ?? Doc();
          return Padding(
            padding: EdgeInsets.only(bottom: kDefaultPadding.h),
            child: Column(
              children: [
                ReviewCardPrimary(
                    userAvatar: review.reviewer?.profile?.avatar?.path ?? "",
                    userName: review.reviewer?.profile?.fullName ?? "",
                    starCount: review.rating ?? 0.0,
                    reviewDate: TGGTUtils().formatToTimeAgo(
                        review.createdAt ?? "0001-01-01T00:00"),
                    reviewContent: review.content ?? "",
                    listImage: review.gallery ?? []),
                SizedBox(height: kDefaultPadding.h),
                Divider(
                  indent: kDefaultPadding.w,
                  endIndent: kDefaultPadding.w,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column buildRating() {
    VendorsDetailController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Obx(
                () => AutoSizeText(
                  TGGTUtils().formatNumber(
                      controller.currentVendor.value.avgRating ?? 0.0),
                  style: AppTextStyle()
                      .titleBold16
                      .copyWith(fontSize: 64.sp, height: 1.2),
                  maxLines: 1,
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: RatingBar(
                ratings: controller.currentVendor.value.reviewStatistics ?? [],
                totalRating: controller.currentVendor.value.totalReviews ?? 0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
