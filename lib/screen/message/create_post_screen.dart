import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/create_post_controller.dart';
import 'package:client_tggt/screen/message/tags/add_tags_controller.dart';
import 'package:client_tggt/screen/message/widget/grid_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final CreatePostController controller =
      Get.put(CreatePostController(getIt.get<ApiClient>()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(defaultPaddingItem.w),
                      margin: EdgeInsets.only(bottom: 5.h),
                      child: const Icon(
                        Ionicons.close_outline,
                        size: 26,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text(
                      "createPost".tr,
                      style: titleStyle,
                    ),
                  ),
                  Obx(() => InkWell(
                        onTap: () {
                          controller.handleCreatePost();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(defaultPaddingItem.w),
                            margin: EdgeInsets.only(top: 10.h),
                            child: controller.isLoadingPost.isFalse
                                ? Text(
                                    "post".tr,
                                    style: titleStyle.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  )
                                : Container(
                                    padding: EdgeInsets.zero,
                                    width: 68.w,
                                    height: 30.h,
                                    child: Lottie.asset(AppPath.appLoading,
                                        frameRate: FrameRate.max),
                                  )),
                      ))
                ],
              ),
              Obx(() => Expanded(child: renderCreateNewPost(context))),
              SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPaddingScreen.w,
                      vertical: kDefaultPaddingWidget.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "addToPost".tr,
                        style: titleStyle.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.router
                                    .push(AddTagsPage(
                                      onBack: (List<VendorModel> vendors) {
                                        // controller.listSelectedVendors.value =
                                        //     selectedVendors;
                                        controller.handleUpdateSelectedVendor(
                                            vendors);
                                      },
                                      vendors: controller.listSelectedVendors,
                                    ))
                                    .then((value) =>
                                        {Get.delete<AddTagsController>()});
                              },
                              child: Icon(
                                Ionicons.pricetags_outline,
                                color: kColorActionAlert,
                                size: 25.sp,
                              ),
                            ),
                            SizedBox(
                              width: defaultPaddingItem.w,
                            ),
                            InkWell(
                              onTap: () {
                                controller.handleUploadImageGallery(
                                    ImageSource.gallery, true);
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              child: Icon(
                                Ionicons.images_outline,
                                color: kColorActionSuccess,
                                size: 23.sp,
                              ),
                            ),
                            SizedBox(
                              width: defaultPaddingItem.w * 1.2,
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              child: InkWell(
                                onTap: () {
                                  controller.handleUploadVideoGallery(
                                      ImageSource.gallery);
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: Icon(
                                  Ionicons.videocam_outline,
                                  color: kColorPrimaryLight,
                                  size: 28.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderCreateNewPost(BuildContext context) {
    final MainController mainController =
        Get.put(MainController(getIt.get<ApiClient>()));
    final account = mainController.account.value;

    return Container(
        padding: EdgeInsets.only(
            top: defaultPaddingItem.h, bottom: defaultPaddingItem.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: account.profile!.avatar!.path ??
                          "https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png",
                      memCacheHeight: 200,
                      placeholder: (context, url) => Expanded(
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      imageBuilder: (context, image) => CircleAvatar(
                        backgroundImage: image,
                        radius: 20,
                      ),
                    ),
                    SizedBox(
                      width: defaultPaddingItem.w,
                    ),
                    Text(
                      account.profile!.fullName ?? "",
                      style: titleStyle,
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: controller.listSelectedVendors.isNotEmpty,
                  child: renderListTags(context)),
              SizedBox(
                height: 5.h,
              ),
              Container(
                  padding:
                      EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => TextFormField(
                        cursorColor: const Color(0xFF9b9b9b),
                        controller: controller.contentPost.value,
                        autofocus: true,
                        minLines: 1,
                        maxLines: 30,
                        onChanged: (value) {
                          if (value != "") {
                            controller.hanleUpdateStatusCreatePost(true);
                          } else if (value == "" &&
                              controller.listLocalImage.isEmpty) {
                            controller.hanleUpdateStatusCreatePost(false);
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "shareExperience".tr,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: context.theme.backgroundColor,
                                    width: 0)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: context.theme.backgroundColor,
                                    width: 0)))),
                  )),
              Visibility(
                  visible: controller.isLoadingPick.isTrue,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: const CircularProgressIndicator(),
                  )),
              Visibility(
                visible: controller.listLocalImage.isNotEmpty &&
                    controller.isLoadingPick.isFalse,
                child: Container(
                  alignment: Alignment.center,
                  child: GridImage(
                    photos: controller.listLocalImage,
                    padding: 0,
                    isLocal: true,
                    onBack: (int index) {},
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget renderListTags(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: defaultPaddingItem.h,
          ),
          // Text("Gắn thẻ:",
          //     style: titleStyle.copyWith(fontWeight: FontWeight.w400)),
          // SizedBox(
          //   height: 5.h,
          // ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: controller.listSelectedVendors.length,
              itemBuilder: (ctx, index) {
                final VendorModel item = controller.listSelectedVendors[index];
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Text(
                      "#${item.brandName}",
                      maxLines: 1,
                      style: TextStyle(
                          color: const Color(0xFF1967d2),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ));
              }),
        ],
      ),
    );
  }
}
