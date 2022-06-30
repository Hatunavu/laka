import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/carousel_gallery_controller.dart';
import 'package:client_tggt/screen/vendors/product/product_detail/gallery/gallery_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';

class ServiceItemGalleryScreen extends StatelessWidget {
  const ServiceItemGalleryScreen({Key? key, this.listGallery, this.serviceId})
      : super(key: key);
  final List<ImageModel>? listGallery;
  final String? serviceId;

  @override
  Widget build(BuildContext context) {
    final ServiceItemGalleryController controller =
        Get.put(ServiceItemGalleryController(getIt.get<ApiClient>()));
    controller.updateServiceItemId(serviceId!);
    controller.updateListGallery(listGallery!);
    return Dismissible(
      key: const ValueKey("GALLLERY SCREEN"),
      direction: DismissDirection.down,
      onDismissed: (dismiss) {
        context.router.pop();
      },
      // confirmDismiss: (direction) async {
      //   return false;
      // },
      child: BaseScreen(
          backgroundColor: Theme.of(context).backgroundColor,
          title: "Thư viện ảnh",
          leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: const Icon(
                Ionicons.chevron_back_outline,
                size: 30,
                color: Colors.black,
              )),
          child: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            // padding:
            //     const EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget),
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  child: controller.listGalleryImage.isEmpty
                      ? const Text("Chưa có ảnh trong thư viện")
                      : Obx(() => renderListGalleryImage(context, controller)),
                )),
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingWidget.h),
                    child: InkWellButton(
                        onPressed: () {
                          if (controller.isLoading.isFalse) {
                            showCupertinoModalPopup<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext dialogContext) {
                                  return CupertinoActionSheet(
                                    title: const Text('Thao tác'),
                                    // message: const Text('Message'),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        child: const Text('Chụp ảnh'),
                                        onPressed: () {
                                          controller.handleUploadImageCamera(
                                              ImageSource.camera);
                                          context.router.pop();
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: const Text('Thư viện hình ảnh'),
                                        onPressed: () {
                                          controller.handleUploadImageGallery(
                                              ImageSource.gallery);
                                          context.router.pop();
                                        },
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      onPressed: () => context.router.pop(),
                                      child: const Text(
                                        'Huỷ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          }
                        },
                        label: "Thêm ảnh",
                        textColor: Colors.white)),
                SizedBox(
                  height: kDefaultPaddingWidget.h,
                ),
              ],
            ),
          )),
    );
  }
}

Widget renderListGalleryImage(
    BuildContext context, ServiceItemGalleryController controller) {
  return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: controller.listGalleryImage.length,
      itemBuilder: (BuildContext context, int index) {
        return Hero(
          tag: "carousel_gallery_screen $index",
          child: GestureDetector(
            onTap: () {
              context.router
                  .push(VendorCarouselGalleryPage(
                      listImage: controller.listGalleryImage,
                      indexImage: index))
                  .then((value) {
                Get.delete<VendorCarouselGalerryController>();
              });
            },
            child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                    color: Colors.teal,
                    width: MediaQuery.of(context).size.width - 4,
                    height: MediaQuery.of(context).size.width - 4,
                    child: CachedNetworkImage(
                      imageUrl: controller.listGalleryImage[index].path ??
                          "https://www.bartender.edu.vn/wp-content/uploads/2017/09/khong-gian-cua-club.jpg",
                      memCacheHeight: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                    ))),
          ),
        );
      });
}
