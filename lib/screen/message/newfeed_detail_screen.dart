import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/message/newfeed_detail_controller.dart';
import 'package:client_tggt/screen/message/widget/action_post.dart';
import 'package:client_tggt/screen/message/widget/comment.dart';
import 'package:client_tggt/screen/message/widget/grid_image.dart';
import 'package:client_tggt/screen/message/widget/item_row.dart';
import 'package:client_tggt/screen/message/widget/newfeed_detail_shimmer.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/textfield/custome_textfile_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewfeedDetailScreen extends StatelessWidget {
  const NewfeedDetailScreen(
      {Key? key, required this.postId, required this.isFocus})
      : super(key: key);
  final String postId;
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    final NewfeedDetailController controller =
        Get.put(NewfeedDetailController(getIt.get<ApiClient>()));
    controller.getPostById(postId);
    final userToken = AccountServices().getUserToken();
    return BaseScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Obx(
        () => controller.isLoading.isTrue
            ? const NewfeedDetailShimmer()
            : GestureDetector(
                child: Column(
                  children: [
                    Visibility(
                      visible: controller.listComment.length == 100000,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.listComment.length,
                        itemBuilder: (ctx, index) {
                          final item = controller.listComment[index];
                          return Container(
                              padding: EdgeInsets.zero,
                              width: kDefaultPaddingWidget.w,
                              child: Text("${item.content}"));
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: controller.listCommentController,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  kDefaultPaddingScreen.w,
                                  0,
                                  kDefaultPaddingScreen.w,
                                  0),
                              child: ItemRow(
                                isDetailPage: true,
                                avatarUrl:
                                    controller.postDetail.value.urlUserAvatar,
                                title: controller.postDetail.value.fullname,
                                // title: "",
                                subtitle: controller
                                    .postDetail.value.displayTimePostCreated,
                                rightWidget: Container(
                                  margin: EdgeInsets.only(
                                      bottom: kDefaultPaddingWidget.h),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.more_horiz),
                                  ),
                                ),
                              ),
                            ),
                            if (controller.postDetail.value.media != null)
                              GridImage(
                                photos: controller.postDetail.value.media,
                                postId: controller.postDetail.value.id,
                                padding: 0,
                                onBack: (int index) async {
                                  log('$index');
                                },
                              ),
                            ActionPost(
                              post: controller.postDetail.value,
                              onPressed: () {
                                controller.handleUpdatePostReaction(
                                    controller.postDetail.value.id, "love");
                              },
                            ),
                            const Divider(thickness: 1),
                            NewfeedComment(
                                controller: controller,
                                isLoadmoreReply:
                                    controller.isLoadMoreReply.value),
                            Container(
                              height: 20.h,
                              alignment: Alignment.center,
                              child: controller.isLoadingMore.value == true
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Container(),
                            ),
                            Container(
                              child: controller.isLoadingUpdateReaction.value ==
                                      true
                                  ? Container()
                                  : Container(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userToken != "",
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                                visible: controller.isReply.isTrue,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                      left: kDefaultPaddingWidget.w,
                                      right: kDefaultPaddingWidget.w,
                                      top: kDefaultPaddingWidget.h),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'reply'.tr,
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: controller.replyFor.value,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                )),
                            CustomeTextFieldComment(
                              controller: controller.contentComment.value,
                              hint: "writeYourComment".tr,
                              isLoading: controller.isLoadingComment.value,
                              focusNode: controller.focusNode,
                              onTap: () {
                                controller.handlePostComment();
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
