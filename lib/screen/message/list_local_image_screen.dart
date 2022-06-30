import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/message/create_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class ListLocalImageScreen extends StatelessWidget {
  const ListLocalImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreatePostController controller =
        Get.put(CreatePostController(getIt.get<ApiClient>()));
    return Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                context.router.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "done".tr,
                  style: titleStyle.copyWith(color: Colors.blue),
                ),
              ),
            )
          ],
        ),
        body: Obx(
          () => controller.listLocalImage.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Text(
                    "noImage".tr,
                    style: titleStyle,
                  ),
                )
              : ListView.builder(
                  itemCount: controller.listLocalImage.length,
                  itemBuilder: (ctx, index) {
                    final galleryItem = controller.listLocalImage[index];
                    return Container(
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 1.5,
                      margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          galleryItem.type == "image"
                              ? renderImage(context, galleryItem.path!)
                              : renderVideo(context, galleryItem.path!),
                          Visibility(
                            visible: galleryItem.type == "video",
                            child: Positioned(
                                top: (MediaQuery.of(context).size.width * 1.5) /
                                        2 -
                                    25,
                                left: (MediaQuery.of(context).size.width / 2) -
                                    25,
                                child: InkWell(
                                  onTap: () {
                                    context.router.push(PlayVideoPage(
                                        path: galleryItem.path!, index: index));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.5),
                                        borderRadius: BorderRadius.circular(
                                            defaultBorderRadius)),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 3.h),
                                      child: const Icon(
                                        Ionicons.play,
                                        color: Colors.white,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          Positioned(
                              right: defaultPaddingItem.w,
                              top: defaultPaddingItem.w,
                              child: InkWell(
                                onTap: () {
                                  controller.handleRemoveLocalImage(
                                      galleryItem.path!);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                          BorderRadius.circular(30.w / 2)),
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 3.h),
                                    child: const Icon(
                                      Ionicons.close,
                                      color: Colors.white,
                                      size: 23,
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    );
                  }),
        ));
  }
}

Widget renderImage(BuildContext context, String path) {
  return Image.file(
    File(path),
    fit: BoxFit.fill,
  );
}

Widget renderVideo(BuildContext context, String path) {
  late VideoPlayerController _videoPlayerController;
  _videoPlayerController = VideoPlayerController.file(File(path))
    ..initialize().then((value) {
      _videoPlayerController.pause();
    });
  return InkWell(child: VideoPlayer(_videoPlayerController));
}
