import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/review/list_review_response/gallery.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shimmer/shimmer.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.userAvatar,
    required this.userName,
    required this.starCount,
    required this.reviewDate,
    required this.reviewContent,
    required this.listImage,
  }) : super(key: key);

  final String userAvatar;
  final String userName;
  final double starCount;
  final String reviewDate;
  final String reviewContent;
  final List<GalleryModel> listImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145.h,
      width: MediaQuery.of(context).size.width * .8,
      padding: EdgeInsets.all(kDefaultPaddingItem.w),
      margin: EdgeInsets.only(right: kDefaultPaddingWidget.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey, width: 0.5.w)),
      child: SizedBox(
        child: ExpandableNotifier(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        maxRadius: 18.r,
                        backgroundImage: CachedNetworkImageProvider(userAvatar),
                        backgroundColor: HexColor(bottomTabDefaultLight),
                      ),
                      SizedBox(width: kDefaultPaddingItem.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(userName,
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp)),
                          SizedBox(height: 2.h),
                          SizedBox(
                            height: 13.h,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (_, index) {
                                return Icon(Icons.star,
                                    color: index < starCount
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondaryVariant,
                                    size: 13.sp);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.only(top: 3.h),
                    child: Text(reviewDate,
                        style: subTitleStyle.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 11.sp)),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPaddingItem.h),
              Expandable(
                collapsed: ExpandableButton(
                  child: Text(reviewContent,
                      style: AppTextStyle()
                          .subtitleRegular14Grey
                          .copyWith(height: 1.2),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
                expanded: ExpandableButton(
                  child: Text(reviewContent,
                      style: subTitleStyle.copyWith(
                          color: HexColor(bottomTabDefaultLight), height: 1.5),
                      softWrap: true),
                ),
              ),
              SizedBox(height: 5.h),
              if (listImage.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h),
                    Container(
                      height: 50.h,
                      padding: EdgeInsets.zero,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: listImage.length > 3 ? 3 : listImage.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 50.w,
                            width: 60.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    listImage[index].path ??
                                        'https://via.placeholder.com/150',
                                  ),
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                      ),
                    )
                    // SizedBox(
                    //   child: GridView.builder(
                    //     padding:
                    //         const EdgeInsets.only(top: kDefaultPaddingItem),
                    //     physics: const NeverScrollableScrollPhysics(),
                    //     shrinkWrap: true,
                    //     gridDelegate:
                    //         const SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: 4,
                    //       childAspectRatio: 1,
                    //       mainAxisSpacing: kDefaultPaddingItem,
                    //       crossAxisSpacing: kDefaultPaddingItem,
                    //     ),
                    //     itemCount: listImage.length < 5 ? listImage.length : 4,
                    //     itemBuilder: (context, index) {
                    //       return ClipRRect(
                    //         borderRadius: BorderRadius.circular(10.r),
                    //         child: index < 3
                    //             ? CachedNetworkImage(
                    //                 imageUrl: listImage[index].path ??
                    //                     'https://via.placeholder.com/150',
                    //                 fit: BoxFit.cover,
                    //                 placeholder: (context, url) =>
                    //                     Shimmer.fromColors(
                    //                   baseColor: Colors.grey.withOpacity(0.4),
                    //                   highlightColor:
                    //                       Colors.grey.withOpacity(0.2),
                    //                   child: Container(
                    //                     color: Colors.white,
                    //                   ),
                    //                 ),
                    //               )
                    //             : Container(
                    //                 decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                       image: CachedNetworkImageProvider(
                    //                           listImage[index].path ??
                    //                               'https://via.placeholder.com/150'),
                    //                       fit: BoxFit.cover),
                    //                 ),
                    //                 child: Stack(
                    //                   children: [
                    //                     BackdropFilter(
                    //                       filter: ImageFilter.blur(
                    //                           sigmaX: 3.0, sigmaY: 3.0),
                    //                       child: Container(
                    //                         decoration: BoxDecoration(
                    //                             color: Colors.white
                    //                                 .withOpacity(0.0)),
                    //                       ),
                    //                     ),
                    //                     Center(
                    //                       child: Text(
                    //                           "+${listImage.length - 3}",
                    //                           style: detailHeadingStyle
                    //                               .copyWith(fontSize: 24.sp)),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
