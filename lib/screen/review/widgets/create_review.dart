import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/review/widgets/create_review_controller.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:client_tggt/model/review/review_model.dart';
import 'package:lottie/lottie.dart';

class CreateReview extends StatelessWidget {
  const CreateReview({
    Key? key,
    required this.orderID,
    this.review,
    required this.callback,
  }) : super(key: key);

  final String orderID;
  final ReviewModel? review;
  final Function(bool isReview) callback;

  @override
  Widget build(BuildContext context) {
    CreateReviewController controller =
        Get.put(CreateReviewController(getIt.get<ApiClient>()));
    controller.checkIsReview(review);
    controller.orderID.value = orderID;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        padding: const EdgeInsets.all(kDefaultPaddingScreen),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kDefaultPaddingItem.h),
              buildRatingBar(context, controller),
              buildDivider(kDefaultPaddingItem.h),
              buildReviewTextField(context, controller),
              if (!controller.isReviewed.value)
                buildReviewImage(controller)
              else
                buildReviewedImageList(controller),
              if (review == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    controller.isLoading.isTrue
                        ? SizedBox(
                            child: Lottie.asset(AppPath.appLoading,
                                frameRate: FrameRate.max),
                            height: 45.h,
                            width: 45.w,
                          )
                        : Visibility(
                            visible: controller.textfieldController.text != "",
                            child: SizedBox(
                              width: 100.w,
                              child: InkWellButton(
                                label: 'send'.tr,
                                onPressed: () async {
                                  callback(await controller.sendReview());
                                },
                              ),
                            ),
                          ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildReviewImage(CreateReviewController controller) {
    return SizedBox(
      child: Obx(() => GridView.builder(
            padding: const EdgeInsets.only(top: kDefaultPaddingItem),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              mainAxisSpacing: kDefaultPaddingItem,
              crossAxisSpacing: kDefaultPaddingItem,
            ),
            itemCount: controller.listImage.length + 1,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: index == controller.listImage.length
                    ? buildButtonShowImagePicker(context, controller)
                    : buildImageBox(context, controller, index),
              );
            },
          )),
    );
  }

  SizedBox buildReviewedImageList(CreateReviewController controller) {
    return SizedBox(
      child: GridView.builder(
        padding: const EdgeInsets.only(top: kDefaultPaddingItem),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: kDefaultPaddingItem,
          crossAxisSpacing: kDefaultPaddingItem,
        ),
        itemCount: controller.review.value.gallery?.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: buildReviewedImageBox(context, controller, index),
          );
        },
      ),
    );
  }

  GestureDetector buildImageBox(
      BuildContext context, CreateReviewController controller, int index) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return CupertinoActionSheet(
                title: Text('action'.tr),
                // message: const Text('Message'),
                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    child: Text('delete'.tr),
                    onPressed: () {
                      controller.listImage.removeAt(index);
                      context.router.pop();
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => context.router.pop(),
                  child: Text(
                    'cancel'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            });
      },
      child: CachedNetworkImage(
        imageUrl: controller.listImage[index],
        memCacheHeight: 200,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  value: progress.progress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildReviewedImageBox(
      BuildContext context, CreateReviewController controller, int index) {
    return GestureDetector(
      onTap: () {},
      child: CachedNetworkImage(
        imageUrl: controller.review.value.gallery?[index].path ?? '',
        memCacheHeight: 200,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                height: 20,
                width: 20,
                margin: const EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  value: progress.progress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildButtonShowImagePicker(
      BuildContext context, CreateReviewController controller) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return CupertinoActionSheet(
                title: Text('action'.tr),
                // message: const Text('Message'),
                actions: <CupertinoActionSheetAction>[
                  CupertinoActionSheetAction(
                    child: Text('camera'.tr),
                    onPressed: () {
                      controller.handlePickImage(ImageSource.camera);
                      context.router.pop();
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: Text('photoLibrary'.tr),
                    onPressed: () {
                      controller.handlePickImage(ImageSource.gallery);
                      context.router.pop();
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () => context.router.pop(),
                  child: Text(
                    'cancel'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Icon(Icons.add, color: Theme.of(context).backgroundColor),
      ),
    );
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

  Widget buildRatingBar(
      BuildContext context, CreateReviewController controller) {
    return RatingBar.builder(
      ignoreGestures: controller.isReviewed.value,
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Theme.of(context).primaryColor,
      ),
      onRatingUpdate: (rating) {
        controller.rating.value = rating;
      },
    );
  }

  SizedBox buildReviewTextField(
      BuildContext context, CreateReviewController controller) {
    return SizedBox(
      child: TextField(
        enabled: !controller.isReviewed.value,
        controller: controller.textfieldController,
        decoration: InputDecoration(
          hintText: 'review'.tr,
          border: InputBorder.none,
        ),
        autocorrect: false,
        maxLength: 500,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
      ),
    );
  }
}
