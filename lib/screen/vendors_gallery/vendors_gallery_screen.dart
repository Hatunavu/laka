import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors_gallery/vendors_gallery_controller.dart';
import 'package:client_tggt/screen/vendors_gallery/widgets/vendors_gallery_detail_controller.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class VendorsGalleryScreen extends StatelessWidget {
  const VendorsGalleryScreen({Key? key, this.listImage}) : super(key: key);
  final List<GalleryModel>? listImage;
  @override
  Widget build(BuildContext context) {
    VendorsGalleryController controller = Get.put(VendorsGalleryController());
    controller.setImage(listImage ?? []);
    return Scaffold(
      appBar: AppBar(
        title: Text('gallery'.tr, style: Theme.of(context).textTheme.headline6),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          onPressed: () {
            Get.delete<VendorsGalleryController>();
            context.router.pop();
          },
          icon: Icon(Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPaddingWidget.w),
        child: Obx(
          () => StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 10,
              itemCount: controller.listImage.length,
              itemBuilder: (BuildContext context, int index) => ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: GestureDetector(
                      onTap: () {
                        context.router
                            .push(VendorsGalleryDetailPage(
                                index: index, listImage: controller.listImage))
                            .then((value) {
                          Get.delete<VendorsGalleryDetailController>();
                        });
                        ;
                      },
                      child: controller.listImage[index].type != "video"
                          ? Hero(
                              tag: 'popup-Image$index',
                              child: SizedBox(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      controller.listImage[index].path ?? "",
                                  // memCacheHeight: 800,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                    baseColor: Colors.grey.withOpacity(0.4),
                                    highlightColor:
                                        Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            )
                          : Hero(
                              tag: 'popup-Image$index',
                              child: FutureBuilder(
                                future: TGGTUtils().generateVideoThumbnail(
                                    controller.listImage[index].path ?? ''),
                                builder:
                                    (context, AsyncSnapshot<File?> snapshot) {
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
                            ),
                    ),
                  ),
              staggeredTileBuilder: (int index) {
                if (index % 3 == 0) {
                  return const StaggeredTile.count(2, 1);
                } else {
                  return const StaggeredTile.count(1, 1);
                }
              }),
        ),
      ),
    );
  }
}
