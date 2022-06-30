import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemRow extends StatelessWidget {
  final String? avatarUrl;
  final double sizeAvatar;
  final String? title;
  final String? subtitle;

  final Widget? avatarWidget;
  final Widget? bodyWidget;
  final Widget? rightWidget;
  final bool? isDetailPage;

  const ItemRow(
      {Key? key,
      this.avatarUrl,
      this.sizeAvatar = 36,
      this.title,
      this.subtitle,
      this.avatarWidget,
      this.bodyWidget,
      this.rightWidget,
      this.isDetailPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                  visible: isDetailPage == true,
                  child: IconButton(
                      onPressed: () {
                        context.router.pop();
                      },
                      icon: Container(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: 19.sp,
                          )))),
              Container(
                margin:
                    EdgeInsets.only(left: 3.w, bottom: defaultPaddingItem.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    avatarWidget ??
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40 / 2),
                            child: CachedNetworkImage(
                                imageUrl: avatarUrl!,
                                memCacheHeight: 200,
                                // placeholder: (context, url) => Expanded(
                                //       child: Container(
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                imageBuilder: (context, image) => CircleAvatar(
                                      backgroundImage: image,
                                      // radius: 20,
                                    )),
                          ),
                        ),
                    SizedBox(width: defaultPaddingItem.w),
                    bodyWidget ?? buildBodyWidget(context),
                  ],
                ),
              ),
            ],
          ),
        ),
        rightWidget ?? const SizedBox(),
      ],
    );
  }

  Widget buildBodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildTitle(context),
        const SizedBox(
          height: 3,
        ),
        buildSubTitle(context),
      ],
    );
  }

  Widget buildTitle(BuildContext context) {
    if (title == null) {
      return const SizedBox();
    }

    return Flexible(
      child: Text(
        title!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyle().titleSemi16.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget buildSubTitle(BuildContext context) {
    if (subtitle == null) {
      return const SizedBox();
    }
    return Container(
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        subtitle!,
        style: AppTextStyle().subtitleRegular14Grey.copyWith(fontSize: 13.sp),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
