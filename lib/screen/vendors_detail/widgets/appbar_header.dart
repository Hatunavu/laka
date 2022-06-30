import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/order/order_controller.dart';
import 'package:client_tggt/screen/vendors_detail/vendors_detail.controller.dart';
import 'package:client_tggt/screen/vendors_gallery/vendors_gallery_binding.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:story_view/story_view.dart';

// class BuildAppbarHeader extends StatelessWidget {
//   const BuildAppbarHeader(
//       {Key? key,
//       required this.listImage,
//       required this.imageCount,
//       required this.isPinned})
//       : super(key: key);

//   final List<GalleryModel> listImage;
//   final int imageCount;
//   final bool isPinned;

//   @override
//   Widget build(BuildContext context) {
//     VendorsDetailController controller = Get.find();
//     return SliverAppBar(
//       backgroundColor: Theme.of(context).backgroundColor,
//       pinned: true,

//       title: Text(
//         controller.currentVendor.value.brandName,
//         style: Theme.of(context)
//             .textTheme
//             .headline6!
//             .copyWith(color: isPinned ? Colors.white : Colors.transparent),
//       ),

//       leading: IconButton(
//         onPressed: () {
//           Get.delete<VendorsDetailController>();
//           Get.delete<OrderController>();
//           context.router.pop();
//         },
//         icon: AspectRatio(
//           aspectRatio: 1,
//           child: Padding(
//             padding: const EdgeInsets.all(kChipPadding),
//             child: Container(
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: ThemeServices().isDarkMode
//                       ? Theme.of(context).primaryColor
//                       : kColorBackgroundLight,
//                   borderRadius: BorderRadius.circular(99)),
//               child: const Icon(
//                 Icons.close_rounded,
//                 color: kColorBackgroundDark,
//                 size: 16,
//               ),
//             ),
//           ),
//         ),
//       ),
//       expandedHeight: 238.0.h,
//       floating: false,
//       flexibleSpace: CarouselSlider(
//         options: CarouselOptions(
//             height: double.infinity,
//             viewportFraction: 1,
//             initialPage: 0,
//             enableInfiniteScroll: true,
//             // enlargeCenterPage: true,
//             reverse: false,
//             autoPlay: true,
//             autoPlayInterval: const Duration(seconds: 4),
//             autoPlayAnimationDuration: const Duration(seconds: 2),
//             scrollDirection: Axis.horizontal,
//             onPageChanged: (index, resson) {
//               // homeController.handleUpdateCarouselIndex(index);
//             },
//             enlargeStrategy: CenterPageEnlargeStrategy.height),
//         items: listImage.map((item) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: CachedNetworkImageProvider(item.path ?? ""),
//                         fit: BoxFit.cover)),
//               );
//             },
//           );
//         }).toList(),
//       ),

// flexibleSpace: FlexibleSpaceBar(
//   background: GestureDetector(
//     //swipe detect
//     onPanEnd: (details) {
//       int sensitive = 10;
//       //left to right
//       if (details.velocity.pixelsPerSecond.dx > sensitive) {
//         controller.storyController.previous();
//       }
//       //right to left
//       if (details.velocity.pixelsPerSecond.dx < -sensitive) {
//         controller.storyController.next();
//       }
//     },

//     onTap: () {
//       VendorsGalleryBinding().dependencies();
//       context.router.push(VendorsGalleryPage(listImage: listImage));
//     },
//     child: AbsorbPointer(
//       child: StoryView(
//         storyItems: [
//           ...listImage.map(
//             (e) => e.type != "video"
//                 ? StoryItem.pageImage(
//                     url: e.path ?? '',
//                     controller: controller.storyController,
//                     imageFit: BoxFit.cover,
//                   )
//                 : StoryItem.pageVideo(
//                     e.path ?? '',
//                     controller: controller.storyController,
//                     imageFit: BoxFit.cover,
//                   ),
//           ),
//         ],
//         controller: controller.storyController,
//         progressPosition: ProgressPosition.bottom,
//         repeat: true,
//       ),
//     ),
//   ),
// ),
//     );
//   }
// }

class BuildAppbarHeader extends StatelessWidget {
  const BuildAppbarHeader({
    Key? key,
    required this.listImage,
    required this.imageCount,
  }) : super(key: key);

  final List<GalleryModel> listImage;
  final int imageCount;

  @override
  Widget build(BuildContext context) {
    VendorsDetailController controller = Get.find();
    return Obx(
      () => SliverAppBar(
        pinned: true,
        backgroundColor: Theme.of(context).backgroundColor,
        title: controller.isPinned.value
            ? Text(
                controller.currentVendor.value.brandName,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: ThemeServices().isDarkMode
                        ? kColorTextDark
                        : kColorTextLight),
              )
            : null,
        leading: IconButton(
          onPressed: () {
            Get.delete<VendorsDetailController>();
            Get.delete<OrderController>();
            context.router.pop();
          },
          icon: Container(
            height: 23.w,
            width: 23.w,
            margin: EdgeInsets.only(bottom: 3.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: kColorBackgroundLight,
                borderRadius: BorderRadius.circular(23.r)),
            child: Icon(
              Icons.close_rounded,
              color: kColorBackgroundDark,
              size: 16.sp,
            ),
          ),
        ),
        expandedHeight: 250.0.h,
        floating: false,
        flexibleSpace: GestureDetector(
          onTap: () {
            VendorsGalleryBinding().dependencies();
            context.router.push(VendorsGalleryPage(listImage: listImage));
          },
          child: FlexibleSpaceBar(
            background: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    onPageChanged: (index, reason) =>
                        controller.currentIndex.value = index + 1,
                  ),
                  items: [
                    if (listImage.isNotEmpty)
                      ...listImage
                          .map(
                            (item) => item.type != "video"
                                ? Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(item
                                                  .path ??
                                              "http://via.placeholder.com/350x150"),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : FutureBuilder(
                                    future: TGGTUtils().generateVideoThumbnail(
                                        item.path ?? ''),
                                    builder: (context,
                                        AsyncSnapshot<File?> snapshot) {
                                      if (snapshot.hasData) {
                                        return Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Image.file(snapshot.data!,
                                                  fit: BoxFit.cover),
                                            ),
                                            const Center(
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                color: Colors.white54,
                                                size: 50,
                                              ),
                                            )
                                          ],
                                        ); // image is ready
                                      } else {
                                        return const SizedBox(); // placeholder
                                      }
                                    },
                                  ),
                          )
                          .toList(),
                  ],
                ),

                Positioned(
                  bottom: 10.h,
                  right: 10.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPaddingWidget.w - 3.w,
                                    vertical: 5.h),
                                child: Row(
                                  children: [
                                    Obx(() => Text(
                                        '${controller.currentIndex.value} / $imageCount',
                                        style: subTitleStyle.copyWith(
                                            color: Colors.white,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w500))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // )
              ],
            ),
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {/* ... */},
        //     icon: Container(
        //       height: 28.h,
        //       width: 28.w,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //           color: kColorBackgroundLight,
        //           borderRadius: BorderRadius.circular(28)),
        //       child: const Icon(
        //         Icons.bookmark_border,
        //         color: kColorPrimaryDark,
        //         size: 16,
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }
}


//   // SvgPicture categoryIcon(CategoryEnum category) {
//   //   switch (category) {
//   //     case CategoryEnum.bar:
//   //       return SvgPicture.asset('assets/icons/bar-icon.svg');
//   //     case CategoryEnum.karaoke:
//   //       return SvgPicture.asset('assets/icons/karaoke-icon.svg');
//   //     case CategoryEnum.restaurant:
//   //       return SvgPicture.asset('assets/icons/restaurant-icon.svg');
//   //     case CategoryEnum.massage:
//   //       return SvgPicture.asset('assets/icons/massage-icon.svg');
//   //   }
//   // }

//   // Text categoryTitle(CategoryEnum category) {
//   //   switch (category) {
//   //     case CategoryEnum.bar:
//   //       return Text('Bar', style: subTitleStyle.copyWith(color: Colors.white));
//   //     case CategoryEnum.karaoke:
//   //       return Text('Karaoke',
//   //           style: subTitleStyle.copyWith(color: Colors.white));
//   //     case CategoryEnum.restaurant:
//   //       return Text('Restaurant',
//   //           style: subTitleStyle.copyWith(color: Colors.white));
//   //     case CategoryEnum.massage:
//   //       return Text('Massage',
//   //           style: subTitleStyle.copyWith(color: Colors.white));
//   //   }
//   // }
// }
