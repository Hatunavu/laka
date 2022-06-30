import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/carousel_gallery_controller.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CarouselGalleryScreen extends StatelessWidget {
  const CarouselGalleryScreen({Key? key, this.listImage, this.indexImage})
      : super(key: key);
  final List<ImageModel>? listImage;
  final int? indexImage;
  @override
  Widget build(BuildContext context) {
    final VendorCarouselGalerryController controller =
        Get.put(VendorCarouselGalerryController());
    return Hero(
      tag: "carousel_gallery_screen $indexImage",
      child: Obx(() => Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0.h,
                      child: InkWell(
                        onTap: () {
                          context.router.pop();
                        },
                        child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(kDefaultPaddingWidget.w),
                            child: Text("Đóng",
                                style: titleStyle.copyWith(
                                    color: kColorPrimaryLight))),
                      ),
                    ),
                    Center(
                      child: Container(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height),
                        margin: EdgeInsets.only(top: 50.h),
                        child: CarouselSlider(
                            items: listImage!.map((image) {
                              return Listener(
                                onPointerDown: (PointerDownEvent event) {
                                  controller
                                      .updateStartPoint(event.position.dy);
                                },
                                onPointerUp: (PointerUpEvent event) {
                                  if (event.position.dy -
                                          controller.startPoint.value >
                                      50) {
                                    context.router.pop();
                                  }
                                },
                                child: Dismissible(
                                  key: ValueKey(indexImage!),
                                  direction: DismissDirection.down,
                                  confirmDismiss: (direction) async {
                                    return false;
                                  },
                                  child: CachedNetworkImage(
                                    width: MediaQuery.of(context).size.width,
                                    memCacheHeight: 200,
                                    imageUrl: image.path ??
                                        "https://www.bartender.edu.vn/wp-content/uploads/2017/09/khong-gian-cua-club.jpg",
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(0.4),
                                      highlightColor:
                                          Colors.grey.withOpacity(0.2),
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 400.h,

                              aspectRatio: 2,
                              viewportFraction: 1,
                              initialPage: indexImage ?? 0,
                              enableInfiniteScroll:
                                  listImage!.length > 1 ? true : false,
                              reverse: false,
                              autoPlay: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              // onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                            )),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Text(
                          '${controller.startPoint.value}',
                          style: const TextStyle(color: Colors.transparent),
                        )),
                    Positioned(
                        bottom: 0,
                        child: Text(
                          '${controller.backgroundOpacity.value}',
                          style: const TextStyle(color: Colors.transparent),
                        )),
                    Positioned(
                        bottom: 0,
                        child: Text(
                          '${controller.imageWidth.value}',
                          style: const TextStyle(color: Colors.transparent),
                        ))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
