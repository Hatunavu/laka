import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'dart:ui' as ui;
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewFeddGallery extends StatelessWidget {
  const NewFeddGallery(
      {Key? key,
      required this.index,
      required this.listImage,
      required this.id})
      : super(key: key);

  final int index;
  final List<GalleryModel> listImage;
  final String id;

  @override
  Widget build(BuildContext context) {
    VendorsGalleryDetailController controller =
        Get.put(VendorsGalleryDetailController());
    controller.listImage.value = listImage;
    controller.index.value = index;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.router.pop();
            Get.delete<VendorsGalleryDetailController>();
          },
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        // GestureDetector(
        //   onVerticalDragEnd: (details) {
        //     int sensitive = 10;
        //     if (details.velocity.pixelsPerSecond.dy > sensitive ||
        //         details.velocity.pixelsPerSecond.dy < -sensitive) {
        //       context.router.pop();
        //       Get.delete<VendorsGalleryDetailController>();
        //     }
        //   },
        Listener(
          onPointerDown: (PointerDownEvent event) {
            controller.updateStartPoint(event.position.dy);
          },
          onPointerUp: (PointerUpEvent event) {
            if (event.position.dy - controller.startPoint.value > 50) {
              context.router.pop();
            }
          },
          child: Dismissible(
            key: ValueKey(index),
            direction: DismissDirection.down,
            confirmDismiss: (direction) async {
              return false;
            },
            child: Center(
              child: Hero(
                tag: 'popup-Image$index$id',
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.h,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    // autoPlay: true,
                    initialPage: index,
                    enlargeCenterPage: true,
                    //scrollPhysics: const NeverScrollableScrollPhysics(),
                  ),
                  carouselController: controller.carouselController.value,
                  items: [
                    if (listImage.isNotEmpty)
                      ...listImage
                          .map((item) => item.type != "video"
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: item.path ?? "",
                                    memCacheHeight: 200,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                  ),
                                )
                              : FutureBuilder(
                                  future: controller
                                      .initializedPlayer(item.path ?? ''),
                                  builder:
                                      (context, AsyncSnapshot<bool?> isReady) {
                                    if (isReady.hasData &&
                                        isReady.data == true) {
                                      return Chewie(
                                          controller:
                                              controller.chewieController!);
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ))
                          .toList(),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: Get.height / 2 - 10,
          left: 0,
          child: IconButton(
            onPressed: () => controller.carouselController.value.previousPage(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white54,
              size: 20,
            ),
          ),
        ),
        Positioned(
          top: Get.height / 2 - 10,
          right: 0,
          child: IconButton(
            onPressed: () => controller.carouselController.value.nextPage(),
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
