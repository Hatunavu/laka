import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/message/tags/add_tags_controller.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AddTagsScreen extends StatefulWidget {
  AddTagsScreen({Key? key, required this.onBack, required this.vendors})
      : super(key: key);
  final Function(
      // List<VendorModel> vendors,
      List<VendorModel> vendors)? onBack;
  final List<VendorModel> vendors;
  @override
  State<AddTagsScreen> createState() => _AddTagsScreenState();
}

class _AddTagsScreenState extends State<AddTagsScreen> {
  final AddTagsController controller =
      Get.put(AddTagsController(getIt.get<ApiClient>()));
  @override
  void initState() {
    controller.handleFilterVendor(widget.vendors);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseScreen(
          title: "tag".tr,
          leading: IconButton(
              onPressed: () {
                context.router.pop();
              },
              icon: Icon(
                Ionicons.chevron_back_outline,
                size: 23.sp,
                color: Colors.black,
              )),
          trailing: [
            InkWell(
              onTap: () async {
                final List<VendorModel> listvendors =
                    controller.listSelectedVendors;
                await widget.onBack?.call(listvendors);
                context.router.pop();
              },
              child: Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
                  child: Text("done".tr,
                      style: titleStyle.copyWith(color: kColorPrimaryLight))),
            ),
          ],
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: kDefaultPaddingScreen.w),
              child: Column(
                children: [
                  renderSeachBar(context),
                  Visibility(
                      visible: controller.listSelectedVendors.isNotEmpty,
                      child: renderSelectedVendor(context, controller)),
                  controller.isLoading.isTrue
                      ? const LoadingScreen()
                      : renderListVendor(context, controller)
                ],
              ),
            ),
          ),
        ));
  }

  Widget renderSeachBar(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        margin: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        width: double.infinity,
        height: 30.h,
        decoration: BoxDecoration(
          // border: Border.all(color: darkGreyClr.withOpacity(.3), width: 1),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                autofocus: true,
                // showCursor: false,
                onChanged: (text) {
                  if (text != "") {
                    controller.handleSearchVendors(text);
                  } else if (text == "") {
                    controller.handleClearSearch();
                  }
                },
                style: subTitleStyle,
                controller: controller.searchText.value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "searchVendor".tr,
                ),
              ),
            ),
            Visibility(
                visible: controller.searchText.value.text != "",
                child: GestureDetector(
                  onTap: () {
                    controller.handleClearSearch();
                  },
                  child: Icon(
                    Ionicons.close_circle_outline,
                    size: 18.sp,
                    color: Colors.grey,
                  ),
                ))
          ],
        ));
  }

  Widget renderSelectedVendor(
      BuildContext context, AddTagsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("picked".tr, style: titleStyle),
          Container(
              height: 72.h,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.listSelectedVendors.length,
                itemBuilder: (ctx, index) {
                  final item = controller.listSelectedVendors[index];
                  return renderVendorItem1(context, item, controller);
                },
              )),
        ],
      ),
    );
  }

  Widget renderListVendor(BuildContext context, AddTagsController controller) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        margin: EdgeInsets.only(
            top: kDefaultPaddingWidget.h, bottom: kDefaultPaddingItem.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("suggest2".tr, style: titleStyle),
            SizedBox(
              height: kDefaultPaddingItem.h,
            ),
            Expanded(
              child: controller.listVendors.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
                      alignment: Alignment.center,
                      child: Text("notResult".tr, style: titleStyle),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      controller: controller.listVendorsController,
                      itemCount: controller.listVendors.length,
                      itemBuilder: (ctx, index) {
                        final item = controller.listVendors[index];
                        return renderVendorItem2(context, item, controller);
                      },
                    ),
            ),
            Visibility(
                visible: controller.isLoadMore.isTrue,
                child: renderLoadmoreShimmer(context))
          ],
        ),
      ),
    );
  }

  Widget renderVendorItem2(BuildContext context, VendorModel vendorItem,
      AddTagsController controller) {
    final findVendors = controller.listSelectedVendors
        .where(
          (element) => element.id == vendorItem.id,
        )
        .toList();

    return InkWell(
      onTap: () {
        controller.handleSelectedVendors(vendorItem);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: vendorItem.thumbnail!.path ?? "",
                  memCacheHeight: 200,
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 20.sp,
                  ),
                ),
                SizedBox(
                  width: kDefaultPaddingItem.w,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  child: Text(
                    vendorItem.brandName,
                    style: titleStyle.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 13.sp),
                  ),
                )
              ],
            ),
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                      color: findVendors.isNotEmpty
                          ? Theme.of(context).primaryColor
                          : const Color(0xFF949AA9))),
              child: Visibility(
                visible: findVendors.isNotEmpty,
                child: Icon(Icons.check,
                    size: 16.sp, color: Theme.of(context).primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget renderVendorItem1(BuildContext context, VendorModel vendorItem,
      AddTagsController controller) {
    return Container(
      width: 80.w,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // CachedNetworkImage(
          //   imageUrl: vendorItem.thumbnail!.path ?? "",
          //   imageBuilder: (context, image) => CircleAvatar(
          //     backgroundImage: image,
          //     radius: 22.sp,
          //   ),
          // ),
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44.r),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      vendorItem.thumbnail!.path ?? ""),
                  fit: BoxFit.cover),
            ),
            child: Stack(children: [
              Positioned(
                  top: -2.h,
                  right: 1.w,
                  child: GestureDetector(
                    onTap: () {
                      controller.handleRemoveVendors(vendorItem);
                    },
                    child: Icon(
                      Ionicons.close_circle_sharp,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ))
            ]),
          ),
          SizedBox(
            height: kDefaultPaddingItem.w,
          ),
          Flexible(
            child: Text(
              vendorItem.brandName,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: titleStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 12.sp, height: 1.2),
            ),
          )
        ],
      ),
    );
  }

  Widget renderLoadmoreShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.4),
        highlightColor: Colors.grey.withOpacity(0.2),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (ctx, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: kDefaultPaddingItem.w,
                    ),
                    Container(
                      height: 15.h,
                      width: 250.w,
                      color: Colors.white,
                    )
                  ],
                ),
              );
            }));
  }
}
