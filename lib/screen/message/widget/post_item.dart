import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_detail_controller.dart';
import 'package:client_tggt/screen/message/widget/action_post.dart';
import 'package:client_tggt/screen/message/widget/grid_image.dart';
import 'package:client_tggt/screen/message/widget/item_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.post,
    this.index,
    this.onPressReaction,
    this.onDeletePost,
    this.onReport,
    this.loadingId,
  }) : super(key: key);
  final PostModel post;
  final int? index;
  final void Function()? onPressReaction;
  final void Function()? onDeletePost;
  final String? loadingId;
  final void Function()? onReport;

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final account = mainController.account.value;
    final userPostId = post.by.id;

    return Container(
      padding: const EdgeInsets.only(top: 8),
      margin: EdgeInsets.only(top: index == 0 ? 0 : defaultPaddingItem.h),
      child: GestureDetector(
        onTap: () => {
          context.router
              .push(NewfeedDetailPage(
            postId: post.id,
            isFocus: false,
          ))
              .then((value) {
            Get.delete<NewfeedDetailController>();
          })
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          color: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: ItemRow(
                      avatarUrl: post.urlUserAvatar,
                      title: post.fullname,
                      subtitle: post.displayTimePostCreated,
                      rightWidget: Container(
                        margin: EdgeInsets.only(bottom: 23.h),
                        // child: IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.more_horiz, size: 18.sp))

                        child: loadingId == post.id
                            ? Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: Lottie.asset(AppPath.appLoading,
                                      frameRate: FrameRate.max),
                                  height: 25.h,
                                  width: 50.w,
                                ),
                              )
                            : PopupMenuButton(
                                itemBuilder: (context) => [
                                      account.id == userPostId
                                          ? PopupMenuItem(
                                              onTap: () {
                                                onDeletePost?.call();
                                              },
                                              child: Text(
                                                "Xoá",
                                                style: titleStyle,
                                              ),
                                              value: 1,
                                            )
                                          : PopupMenuItem(
                                              onTap: () {
                                                onReport?.call();
                                              },
                                              child: Text(
                                                "Báo cáo",
                                                style: titleStyle,
                                              ),
                                              value: 1,
                                            ),
                                    ]),
                      ),
                    ),
                  ),
                ),
                GridImage(
                  photos: post.media,
                  postId: post.id,
                ),
                ActionPost(
                  post: post,
                  onPressed: onPressReaction,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
