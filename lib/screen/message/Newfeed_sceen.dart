import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/create_post_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/message/widget/newfeed_shimmer.dart';
import 'package:client_tggt/screen/message/widget/post_item.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/not_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

class NewfeedScreen extends StatelessWidget {
  const NewfeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewfeedController controller =
        Get.put(NewfeedController(getIt.get<ApiClient>()));
    final MainController mainController =
        Get.put(MainController(getIt.get<ApiClient>()));
    if (mainController.userToken.value != "") {
      controller.getListPost();
    }
    return Obx(() => mainController.userToken.value == ""
        ? NotLoginScreen(
            title: "loginToSeeNewfeed".tr,
            subTitle: "loginToSeeNotificationLabel".tr)
        : BaseScreen(
            backgroundColor: Theme.of(context).backgroundColor,
            child: controller.isLoading.isTrue
                ? const NewfeedShimmer()
                : renderListPost(context, controller),
          ));
  }
}

Widget renderListPost(BuildContext context, NewfeedController controller) {
  return RefreshIndicator(
    onRefresh: () async {
      await Future.delayed(const Duration(milliseconds: 1000));
      controller.getListPost();
    },
    child: Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // renderCreateNewPost(context, controller),
          renderHeaderNewfeed(context, controller),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
                controller: controller.listPostController,
                primary: false,
                // ignore: invalid_use_of_protected_member
                itemCount: controller.listPosts.value.length,
                itemBuilder: (context, int index) {
                  final PostModel item =
                      // ignore: invalid_use_of_protected_member
                      controller.listPosts.value[index];
                  return InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onDoubleTap: () {
                      controller.handleUpdatePostReaction(item.id, "love");
                    },
                    child: PostItem(
                      post: item,
                      index: index,
                      onPressReaction: () {
                        controller.handleUpdatePostReaction(item.id, "love");
                      },
                      onDeletePost: () {
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          () {
                            showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext dialogContext) {
                                  return CustomCupertinoAlert(
                                    context: context,
                                    title: "Thông báo",
                                    content:
                                        'Bạn chắc chắn muốn xoá bài chia sẻ này',
                                    rightButtonTitle: 'confirm'.tr,
                                    rightAction: () async {
                                      Navigator.pop(context);
                                      final status = await controller
                                          .deletePostById(item.id);
                                      if (status == true) {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CupertinoAlertDialog(
                                                  title:
                                                      Text("notification".tr),
                                                  content: const Text(
                                                      "Xoá bài viết thành công"),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                        child:
                                                            Text("confirm".tr),
                                                        onPressed: () {
                                                          context.router.pop();
                                                        })
                                                  ],
                                                ));
                                      } else {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CupertinoAlertDialog(
                                                  title:
                                                      Text("notification".tr),
                                                  content: const Text(
                                                      "Đã có lỗi xảy ra, vui lòng thử lại sau"),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                        child:
                                                            Text("cancel".tr),
                                                        onPressed: () {
                                                          context.router.pop();
                                                        })
                                                  ],
                                                ));
                                      }
                                    },
                                  );
                                });
                          },
                        );
                      },
                      onReport: () {
                        Future.delayed(const Duration(milliseconds: 200), () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: Text("notification".tr),
                                    content: Text("reportSuccess".tr),
                                    actions: [
                                      CupertinoDialogAction(
                                          child: Text("confirm".tr),
                                          onPressed: () {
                                            context.router.pop();
                                          })
                                    ],
                                  ));
                        });
                      },
                      loadingId: controller.loadingId.value,
                    ),
                  );
                }),
          ),
          Container(
            child: controller.isLoadingUpdateReaction.value == true
                ? Container()
                : Container(),
          )
        ],
      ),
    ),
  );
}

Widget renderHeaderNewfeed(BuildContext context, NewfeedController controller) {
  return Container(
    padding: EdgeInsets.fromLTRB(kDefaultPaddingScreen.w, 0,
        kDefaultPaddingScreen.w, kDefaultPaddingWidget.h),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppPath.logo,
                    color: Theme.of(context).primaryColor,
                    width: 40.w,
                    // height: 60,
                  ),
                  SizedBox(
                    width: kDefaultPaddingWidget.w,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.h),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText("newfeedHeaderTitle".tr,
                            textStyle: AppTextStyle().subtitleRegular14),
                      ],
                      totalRepeatCount: 100,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      context.router.push(CreatPostPage()).then((value) {
                        Get.delete<CreatePostController>();
                        controller.getListPost();
                      });
                    },
                    child: const Icon(Ionicons.create_outline)),
                SizedBox(
                  width: defaultPaddingItem.w,
                ),
                Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: const Icon(Ionicons.search_outline)),
              ],
            )
          ],
        ),
      ],
    ),
  );
}
