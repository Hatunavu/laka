import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/message/widget/icon_post_comment.dart';
import 'package:client_tggt/screen/message/widget/text_count_number.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:auto_route/auto_route.dart';

class ActionPost extends StatelessWidget {
  const ActionPost({Key? key, required this.post, this.onPressed})
      : super(key: key);
  final PostModel post;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final userToken = AccountServices().getUserToken();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (post.content != null && post.content!.trim().isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 8),
            child: Text(post.content!,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(height: 1.3, fontWeight: FontWeight.w500)),
          ),
        if (post.tags != null)
          Visibility(
            visible: post.tags!.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(top: 6.h),
              padding:
                  EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: post.tags!.length,
                  itemBuilder: (ctx, index) {
                    final VendorModel item = post.tags![index].vendor;
                    return GestureDetector(
                      onTap: () {
                        context.router.push(
                          VendorsDetailPage(
                              first: item.id ?? '',
                              last: item.category.getType(),
                              tagId: "tags-${item.id}",
                              imageUrl: item.thumbnail?.path ?? "",
                              vendorTitle: item.brandName,
                              vendorsInfo: item),
                        );
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Text(
                            "@${item.brandName}",
                            maxLines: 1,
                            style: TextStyle(
                                color: const Color(0xFF1967d2),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          )),
                    );
                  }),
            ),
          ),
        Visibility(
          visible: userToken != "",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 4),
                    child: GestureDetector(
                      onTap: onPressed,
                      child: post.reacted != null
                          ? Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                CupertinoIcons.heart_solid,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(8),
                              child: const Icon(CupertinoIcons.heart),
                            ),
                    ),
                  ),
                  const IconPostComment(),
                ],
              ),
            ],
          ),
        ),
        Visibility(
          visible: userToken == "",
          child: SizedBox(height: kDefaultPaddingItem.h),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12, bottom: defaultPaddingItem.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextCountNumber(
                number: post.totalReactions!.love.toInt(),
                subText: 'like'.tr,
              ),
              TextCountNumber(
                number: post.totalComments,
                subText: 'comment'.tr,
              ),
            ],
          ),
        )
      ],
    );
  }
}
