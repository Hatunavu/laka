import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/newfeed/post/photo.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class GridImage extends StatefulWidget {
  const GridImage({
    Key? key,
    this.isLocal = false,
    this.onBack,
    this.photos,
    this.postId,
    this.padding = 16,
  }) : super(key: key);
  final List<GalleryModel>? photos;
  final double padding;
  final bool? isLocal;
  final String? postId;
  final Function(
    int index,
  )? onBack;
  @override
  _GridImageState createState() => _GridImageState();
}

class _GridImageState extends State<GridImage> {
  var listIndexVideo = <int>[];

  @override
  void initState() {
    super.initState();
    final listIndex = <int>[];
    for (int i = 0; i < widget.photos!.length; i++) {
      if (widget.photos![i].type == "video") {
        listIndex.add(i);
      }
    }
    setState(() {
      listIndexVideo = listIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return buildImageGrid(widget.photos!, width, context);
  }

  Widget buildImageGrid(
      List<GalleryModel> photos, double width, BuildContext context) {
    switch (photos.length) {
      case 0:
        return const SizedBox();
      case 1:
        return _buildOneImage(photos[0], width, context);
      case 2:
        return _buildTwoImage(photos, width, context);
      case 3:
        return _buildThreeImage(photos, width, context);
      case 4:
        return _buildFourImage(photos, width, context);
      case 5:
        return _buildMoreFiveImage(photos, width, context);
      default:
        return _buildMoreFiveImage(photos, width, context);
    }
  }

  Widget _buildOneImage(
    GalleryModel photo,
    double width,
    BuildContext context,
  ) {
    return GestureDetector(
        onTap: () {
          widget.onBack?.call(1) ?? 123;
        },
        child: photo.dimensions == null
            ? SizedBox(
                height: 300.h,
                width: width,
                child: renderImage(
                    context, photo.path ?? "", photo.type, 0, 300.h),
              )
            : SizedBox(
                height: (photo.dimensions!.height == null ||
                        photo.dimensions!.width == null)
                    ? 300.h
                    : width *
                        (photo.dimensions!.height! / photo.dimensions!.width!),
                width: width,
                child: renderImage(
                    context,
                    photo.path ?? "",
                    photo.type,
                    0,
                    (photo.dimensions!.height == null ||
                            photo.dimensions!.width == null)
                        ? 300.h
                        : width *
                            (photo.dimensions!.height! /
                                photo.dimensions!.width!)),
              ));
  }

  Widget _buildTwoImage(
      List<GalleryModel> photos, double width, BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: (MediaQuery.of(context).size.width - widget.padding) / 2,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
              width:
                  (MediaQuery.of(context).size.width - widget.padding - 1) / 2,
              height: (MediaQuery.of(context).size.width - widget.padding) / 2,
              margin: const EdgeInsets.only(right: 1),
              child: GestureDetector(
                child: renderImage(
                    context,
                    photos[0].path ?? "",
                    photos[0].type,
                    0,
                    (MediaQuery.of(context).size.width - widget.padding) / 2),
              )),
          Container(
              padding: EdgeInsets.zero,
              width:
                  (MediaQuery.of(context).size.width - widget.padding - 1) / 2,
              height: (MediaQuery.of(context).size.width - widget.padding) / 2,
              child: GestureDetector(
                child: renderImage(
                    context,
                    photos[1].path ?? "",
                    photos[1].type,
                    1,
                    (MediaQuery.of(context).size.width - widget.padding) / 2),
              )),
        ],
      ),
    );
  }

  Widget _buildThreeImage(
      List<GalleryModel> photos, double width, BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 1),
              width: MediaQuery.of(context).size.width - widget.padding,
              height: MediaQuery.of(context).size.width * 2 / 3,
              child: GestureDetector(
                child: renderImage(
                    context,
                    photos[0].path ?? "",
                    photos[0].type,
                    0,
                    MediaQuery.of(context).size.width * 2 / 3),
              )),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(right: 1),
                  width: (MediaQuery.of(context).size.width -
                          (widget.padding + 1)) /
                      2,
                  height: MediaQuery.of(context).size.width * 1 / 3,
                  child: GestureDetector(
                    child: renderImage(
                        context,
                        photos[1].path ?? "",
                        photos[1].type,
                        1,
                        MediaQuery.of(context).size.width * 1 / 3),
                  )),
              Container(
                  padding: EdgeInsets.zero,
                  width: (MediaQuery.of(context).size.width -
                          (widget.padding + 1)) /
                      2,
                  height: MediaQuery.of(context).size.width * 1 / 3,
                  child: GestureDetector(
                    child: renderImage(
                        context,
                        photos[2].path ?? "",
                        photos[2].type,
                        2,
                        MediaQuery.of(context).size.width * 1 / 3),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoreFiveImage(
      List<GalleryModel> photos, double width, BuildContext context) {
    // first vertical style images

    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 1),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.zero,
                        width: ((MediaQuery.of(context).size.width -
                                (widget.padding + 1)) /
                            2),
                        margin: const EdgeInsets.only(right: 1),
                        height: (MediaQuery.of(context).size.width - 2) * 2 / 3,
                        child: GestureDetector(
                          child: renderImage(
                              context,
                              photos[0].path ?? "",
                              photos[0].type,
                              1,
                              (MediaQuery.of(context).size.width - 2) * 2 / 3),
                        )),
                    Container(
                        padding: EdgeInsets.zero,
                        width: ((MediaQuery.of(context).size.width -
                                (widget.padding + 1)) /
                            2),
                        height: (MediaQuery.of(context).size.width - 2) * 2 / 3,
                        child: GestureDetector(
                          child: renderImage(
                              context,
                              photos[1].path ?? "",
                              photos[1].type,
                              1,
                              (MediaQuery.of(context).size.width - 2) * 2 / 3),
                        )),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(right: 1),
                      width: (MediaQuery.of(context).size.width -
                              (widget.padding + 2)) /
                          3,
                      height: MediaQuery.of(context).size.width * 1 / 3,
                      child: GestureDetector(
                        child: renderImage(
                            context,
                            photos[2].path ?? "",
                            photos[2].type,
                            2,
                            MediaQuery.of(context).size.width * 1 / 3),
                      )),
                  Container(
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(right: 1),
                      width: (MediaQuery.of(context).size.width -
                              (widget.padding + 2)) /
                          3,
                      height: MediaQuery.of(context).size.width * 1 / 3,
                      child: GestureDetector(
                        child: renderImage(
                            context,
                            photos[3].path ?? "",
                            photos[3].type,
                            3,
                            MediaQuery.of(context).size.width * 1 / 3),
                      )),
                  Container(
                      padding: EdgeInsets.zero,
                      width: (MediaQuery.of(context).size.width -
                              (widget.padding + 2)) /
                          3,
                      height: MediaQuery.of(context).size.width * 1 / 3,
                      child: GestureDetector(
                        child: renderImage(
                            context,
                            photos[4].path ?? "",
                            photos[4].type,
                            4,
                            MediaQuery.of(context).size.width * 1 / 3),
                      )),
                ],
              ),
            ],
          ),
          Visibility(
            visible: photos.length > 5,
            child: Positioned(
                right: 0,
                bottom: 0,
                width:
                    (MediaQuery.of(context).size.width - (widget.padding + 2)) /
                        3,
                height: MediaQuery.of(context).size.width * 1 / 3,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('+ ',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text('${photos.length - 5}',
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _buildFourImage(
      List<GalleryModel> photos, double width, BuildContext context) {
    // first vertical style images

    return Container(
      padding: EdgeInsets.zero,
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 1),
              width: MediaQuery.of(context).size.width - 16,
              height: MediaQuery.of(context).size.width * 2 / 3,
              child: GestureDetector(
                child: renderImage(
                    context,
                    photos[0].path ?? "",
                    photos[0].type,
                    0,
                    MediaQuery.of(context).size.width * 2 / 3),
              )),
          Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(right: 1),
                  width: (MediaQuery.of(context).size.width -
                          (widget.padding + 2)) /
                      3,
                  height: MediaQuery.of(context).size.width * 1 / 3,
                  child: GestureDetector(
                    child: renderImage(
                        context,
                        photos[1].path ?? "",
                        photos[1].type,
                        1,
                        MediaQuery.of(context).size.width * 1 / 3),
                  )),
              Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(right: 1),
                  width: (MediaQuery.of(context).size.width -
                          (widget.padding + 2)) /
                      3,
                  height: MediaQuery.of(context).size.width * 1 / 3,
                  child: GestureDetector(
                    child: renderImage(
                        context,
                        photos[2].path ?? "",
                        photos[2].type,
                        2,
                        MediaQuery.of(context).size.width * 1 / 3),
                  )),
              Container(
                  padding: EdgeInsets.zero,
                  width: (MediaQuery.of(context).size.width -
                          (widget.padding + 2)) /
                      3,
                  height: MediaQuery.of(context).size.width * 1 / 3,
                  child: GestureDetector(
                    child: renderImage(
                        context,
                        photos[3].path ?? "",
                        photos[3].type,
                        3,
                        MediaQuery.of(context).size.width * 1 / 3),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget renderImage(BuildContext context, String path, String? type, int index,
      double height) {
    if (type == "image") {
      if (widget.isLocal == true) {
        return InkWell(
          onTap: () {
            context.router.push(const ListLocalImagePage());
          },
          child: Image.file(
            File(path),
            fit: BoxFit.cover,
          ),
        );
      } else {
        return InkWell(
          onTap: () {
            context.router
                .push(VendorsGalleryDetailPage(
                    index: index, listImage: widget.photos!))
                .then((value) {
              Get.delete<VendorsGalleryDetailController>();
            });
            ;
          },
          child: CachedNetworkImage(
            imageUrl: path,
            memCacheHeight: 600,
            fit: BoxFit.cover,
            // placeholder: (context, url) => Shimmer.fromColors(
            //   baseColor: Colors.grey.withOpacity(0.4),
            //   highlightColor: Colors.grey.withOpacity(0.2),
            //   child: Expanded(
            //     child: Container(
            //       color: Colors.white,
            //     ),
            //   ),
            // ),
          ),
        );
      }
    } else if (type == "video") {
      if (widget.isLocal == true) {
        late VideoPlayerController _videoPlayerController;
        _videoPlayerController = VideoPlayerController.file(File(path))
          ..initialize().then((value) {
            _videoPlayerController.pause();
          });
        return InkWell(
            onTap: () {
              context.router
                  .push(VendorsGalleryDetailPage(
                      index: index, listImage: widget.photos!))
                  .then((value) {
                Get.delete<VendorsGalleryDetailController>();
              });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                VideoPlayer(_videoPlayerController),
                Positioned(
                    bottom: (height - 120) / 2,
                    left: (MediaQuery.of(context).size.width - 120.w) / 2,
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius)),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: Icon(
                            Ionicons.play_sharp,
                            color: Colors.white,
                            size: 39.sp,
                          ),
                        ),
                      ),
                    ))
              ],
            ));
      } else {
        late VideoPlayerController _videoPlayerController;
        _videoPlayerController = VideoPlayerController.network(path)
          ..initialize().then((value) {
            _videoPlayerController.pause();
          });
        return InkWell(
            onTap: () {
              context.router
                  .push(VendorsGalleryDetailPage(
                      index: index, listImage: widget.photos!))
                  .then((value) {
                Get.delete<VendorsGalleryDetailController>();
              });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                VideoPlayer(_videoPlayerController),
                Positioned(
                    bottom: (height - 120) / 2,
                    left: (MediaQuery.of(context).size.width - 120.w) / 2,
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius)),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 3.h),
                          child: Icon(
                            Ionicons.play_sharp,
                            color: Colors.white,
                            size: 39.sp,
                          ),
                        ),
                      ),
                    ))
              ],
            ));
      }
    } else {
      return Container();
    }
  }

  void navigateToPhotoPage(
      List<Photo> photos, int index, BuildContext context) {}
}
