import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'dart:ui' as ui;
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VendorsGalleryDetail extends StatefulWidget {
  VendorsGalleryDetail({Key? key, required this.index, required this.listImage})
      : super(key: key);
  final int index;
  final List<GalleryModel> listImage;
  @override
  State<VendorsGalleryDetail> createState() => _VendorsGalleryDetailState();
}

class _VendorsGalleryDetailState extends State<VendorsGalleryDetail> {
  VendorsGalleryDetailController controller =
      Get.put(VendorsGalleryDetailController());
  late var isPlayVideo = false;
  @override
  void initState() {
    controller.listImage.value = widget.listImage;
    controller.index.value = widget.index;
    final findVideo =
        widget.listImage.where((element) => element.type == "video").toList();
    setState(() {
      isPlayVideo = findVideo.isNotEmpty ? true : false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
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
            Listener(
              onPointerDown: (PointerDownEvent event) {
                controller.updateStartPoint(event.position.dy);
              },
              onPointerUp: (PointerUpEvent event) {
                if (event.position.dy - controller.startPoint.value > 100.h) {
                  // controller.chewieController?.dispose();
                  if (controller.isPlayVideo.isTrue) {
                    controller.videoPlayerController.dispose();
                    controller.chewieController?.dispose();
                    controller.isPlayVideo.value = false;
                  }
                  context.router.pop();
                }
              },
              child: Dismissible(
                key: ValueKey(widget.index),
                direction: DismissDirection.down,
                confirmDismiss: (direction) async {
                  return false;
                },
                child: Center(
                  child: Hero(
                    tag: 'popup-Image${widget.index}',
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: 400.h,
                          viewportFraction: 1,
                          enableInfiniteScroll:
                              widget.listImage.length > 1 ? true : false,
                          reverse: false,
                          autoPlay: false,
                          initialPage: widget.index,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            if (controller.isPlayVideo.isTrue) {
                              // controller.chewieController?.dispose();
                              controller.videoPlayerController.pause();
                              // controller.isPlayVideo.value = false;
                            }
                          }
                          //scrollPhysics: const NeverScrollableScrollPhysics(),
                          ),
                      carouselController: controller.carouselController.value,
                      items: [
                        if (widget.listImage.isNotEmpty)
                          ...widget.listImage
                              .map((item) => item.type != "video"
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: item.path ?? "",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                                baseColor: Colors.grey
                                                    .withOpacity(0.4),
                                                highlightColor: Colors.grey
                                                    .withOpacity(0.2),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  color: Colors.white,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30.w,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30.w,
                                                )),
                                      ),
                                    )
                                  : FutureBuilder(
                                      future: controller
                                          .initializedPlayer(item.path ?? ''),
                                      builder: (context,
                                          AsyncSnapshot<bool?> isReady) {
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
              top: kDefaultPaddingWidget.h * 3,
              left: kDefaultPaddingScreen.w,
              child: SizedBox(
                height: 50.h,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: IconButton(
                    onPressed: () {
                      Get.delete<VendorsGalleryDetailController>();
                      if (controller.isPlayVideo.isTrue) {
                        controller.videoPlayerController.dispose();
                        controller.chewieController?.dispose();
                        controller.isPlayVideo.value = false;
                      }
                      context.router.pop();
                    },
                    icon: Padding(
                      padding: const EdgeInsets.all(kChipPadding),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ThemeServices().isDarkMode
                                ? Theme.of(context).primaryColor
                                : kColorBackgroundLight,
                            borderRadius: BorderRadius.circular(99)),
                        child: const Icon(
                          Icons.close_rounded,
                          color: kColorBackgroundDark,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.listImage.length > 1,
              child: Positioned(
                top: Get.height / 2 - 10,
                left: 0,
                child: IconButton(
                  onPressed: () =>
                      controller.carouselController.value.previousPage(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white54,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.listImage.length > 1,
              child: Positioned(
                top: Get.height / 2 - 10,
                right: 0,
                child: IconButton(
                  onPressed: () =>
                      controller.carouselController.value.nextPage(),
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white54,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
