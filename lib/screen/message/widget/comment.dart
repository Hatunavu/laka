import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/model/newfeed/comment/comment.dart';
import 'package:client_tggt/screen/message/newfeed_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewfeedComment extends StatelessWidget {
  const NewfeedComment(
      {Key? key, required this.controller, required this.isLoadmoreReply})
      : super(key: key);
  final NewfeedDetailController controller;
  final bool isLoadmoreReply;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        final comment = controller.listComment[index];
        final List<CommentItem> listReply =
            comment.replies != null ? comment.replies!.docs : [];

        return Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                  bottom: BorderSide(width: 0.5, color: Colors.black12))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0),
                child: commentItemBubble(
                  context,
                  controller,
                  false,
                  comment,
                  (type, isUnReact) {
                    // if(!isUnReact){
                    //   commentBloc!.react(comment.id!, type);
                    // }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: kDefaultPaddingWidget.w),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    final comment = listReply[index];
                    return Container(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: commentItemBubble(
                              context,
                              controller,
                              true,
                              comment,
                              (type, isUnReact) {
                                // if(!isUnReact){
                                //   commentBloc!.react(comment.id!, type);
                                // }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: listReply.length,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: comment.replies != null &&
                        comment.replies!.metadata!.totalDocs > listReply.length
                    ? isLoadmoreReply == true
                        ? SizedBox(
                            height: kDefaultPaddingWidget.h,
                            width: kDefaultPaddingWidget.w,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              controller.getMoreReplyComment(
                                  comment.id!,
                                  comment.replies!.metadata!.totalDocs -
                                      listReply.length);
                            },
                            child: Text(
                              "${'showMore'.tr} ${comment.replies!.metadata!.totalDocs - listReply.length} ${'answer'.tr}",
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w500),
                            ),
                          )
                    : Container(),
              )
            ],
          ),
        );
      },
      itemCount: controller.listComment.length,
    );
  }
}

Widget commentItemBubble(
    BuildContext context,
    NewfeedDetailController controller,
    bool isReply,
    final CommentItem cmt,
    final Function(int, bool) onReact) {
  double sizeAvatar = 32;
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingScreen.h, vertical: kDefaultPaddingWidget.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: sizeAvatar,
          height: sizeAvatar,
          margin: EdgeInsets.only(top: 2.h),
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(sizeAvatar / 2),
            child: CachedNetworkImage(
                imageUrl: cmt.urlUserAvatar!,
                memCacheHeight: 200,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                    )),
          ),
        ),
        // const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: RichText(
                  text: TextSpan(
                    text: cmt.displayName,
                    style: AppTextStyle().titleSemi16.copyWith(height: 1.2),
                    children: <TextSpan>[
                      const TextSpan(text: ' '),
                      TextSpan(
                          text: cmt.content ?? "",
                          style: AppTextStyle()
                              .titleRegular16
                              .copyWith(height: 1.2)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: defaultPaddingItem.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Text(
                      cmt.displayTimeComment,
                      style: AppTextStyle()
                          .subtitleRegular14Grey
                          .copyWith(fontSize: 13.sp),
                    ),
                    SizedBox(width: defaultPaddingItem.w),
                    Visibility(
                      visible: isReply == false,
                      child: InkWell(
                        onTap: () {
                          controller.hanleSelectComment(cmt);
                        },
                        child: Text(
                          'reply'.tr,
                          style: AppTextStyle()
                              .subtitleRegular14Grey
                              .copyWith(fontSize: 13.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
