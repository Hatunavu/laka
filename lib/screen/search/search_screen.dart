// import 'package:auto_route/src/router/auto_router_x.dart';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/core/style/search_style.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/favorite_place_model.dart';
import 'package:client_tggt/model/search/search_recent_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/home/widget/popular_place_widget.dart';
import 'package:client_tggt/screen/notification/widget/notification_shimmer.dart';
import 'package:client_tggt/screen/search/search_controller.dart';
import 'package:client_tggt/screen/search/widget/search_item.dart';
import 'package:client_tggt/screen/search/widget/search_result_item.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen_secondary.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, this.category}) : super(key: key);
  final String? category;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController controller =
      Get.put(SearchController(getIt.get<ApiClient>()));
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller.category.value = widget.category ?? "";
    if (widget.category == "" || widget.category == null) {
      controller.searchBarTitle.value = 'searchBarTitle'.tr;
    } else if (widget.category == CategoryType.bar.getType()) {
      controller.searchBarTitle.value = "searchBarClubTitle".tr;
    } else if (widget.category == CategoryType.karaoke.getType()) {
      controller.searchBarTitle.value = "searchKaraokeTitle".tr;
    } else if (widget.category == CategoryType.massage.getType()) {
      controller.searchBarTitle.value = "searchMassageTitle".tr;
    } else if (widget.category == CategoryType.restaurant.getType()) {
      controller.searchBarTitle.value = "searchRestaurantTitle".tr;
    }
    scrollController.addListener(listen);

    super.initState();
  }

  listen() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenSecondary(
        child: Obx(
      () => Container(
          padding: EdgeInsets.only(
              top: kDefaultPaddingWidget.h,
              left: kDefaultPaddingScreen.w,
              right: kDefaultPaddingScreen.w),
          child: Column(
            children: [
              renderSeachBar(context, controller),
              renderListCategory(context),
              // Container(
              //   width: double.infinity,
              //   margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
              //   height: 2.h,
              //   color: Theme.of(context).primaryColor,
              // ),
              controller.isLoadingHistory.isTrue
                  ? const LoadingScreen()
                  : Expanded(
                      child: controller.isLoading.isTrue
                          ? const NotificationShimmer()
                          : controller.isSearchStatus.value == 1
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: kDefaultPaddingWidget.h),
                                  child: Text("cantFindResult".tr,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle()
                                          .titleRegular16
                                          .copyWith(height: 1.3)),
                                )
                              : controller.listSearchResult.isEmpty
                                  ? SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      controller: scrollController,
                                      child: Column(
                                        children: [
                                          controller
                                                  .listSearchHistory.isNotEmpty
                                              ? renderHistorySearch(context)
                                              : renderSearchByLocation(context,
                                                  controller.listSeachRecent),
                                          Visibility(
                                            visible: controller
                                                .listSearchResult.isEmpty,
                                            child: renderPopularCity(
                                                context, controller),
                                          ),
                                          Visibility(
                                            visible: controller
                                                .listSearchResult.isEmpty,
                                            child: renderListSuggestVendor(
                                                context),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.zero,
                                      child: renderListResultSearch(context)),
                    )
            ],
          )),
    ));
  }

  Widget renderListResultSearch(BuildContext context) {
    final listResult = controller.category.value == ""
        ? controller.listSearchResult
        : controller.listSearchResult
            .where(
                (item) => item.category.getType() == controller.category.value)
            .toList();
    return Column(
      children: [
        controller.isEmptyResult.isTrue
            ? Visibility(
                visible: controller.isEmptyResult.isTrue &&
                    controller.searchText.value.text != "",
                child: Container(
                  padding: EdgeInsets.only(top: kDefaultPaddingWidget.h),
                  child: Text("cantFindResult".tr,
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyle().titleRegular16.copyWith(height: 1.3)),
                ),
              )
            : Expanded(
                child: listResult.isEmpty
                    ? Container(
                        padding: EdgeInsets.only(top: kDefaultPaddingWidget.h),
                        child: Text("cantFindResult".tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyle()
                                .titleRegular16
                                .copyWith(height: 1.3)),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: listResult.length,
                        itemBuilder: (context, int index) {
                          final VendorModel item = listResult[index];
                          return Container(
                            padding: EdgeInsets.zero,
                            child: Hero(
                              tag: "search-${listResult[index].id}",
                              child: SearchResultItem(
                                  vendorInfo: item, index: index),
                            ),
                          );
                        }),
              ),
        Visibility(
            visible: controller.isSearchStatus.value == 10,
            child: Text(controller.isSearchStatus.value.toString()))
      ],
    );
  }

  Widget renderListCategory(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          top: kDefaultPaddingWidget.h, bottom: kDefaultPaddingItem.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderCateogryItem(context, "all".tr, ""),
          renderCateogryItem(context, CategoryType.restaurant.display(),
              CategoryType.restaurant.getType()),
          renderCateogryItem(context, CategoryType.karaoke.display(),
              CategoryType.karaoke.getType()),
          renderCateogryItem(
              context, CategoryType.bar.display(), CategoryType.bar.getType()),
          renderCateogryItem(context, CategoryType.massage.display(),
              CategoryType.massage.getType())
        ],
      ),
    );
  }

  Widget renderSearchByLocation(
      BuildContext context, List<SearchRecentModel> listRecentSearch) {
    final HomeController homeController =
        Get.put(HomeController(getIt.get<ApiClient>()));
    return Container(
      margin: EdgeInsets.only(bottom: 6.h, top: 6.h),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                if (homeController.statusPermissionGranted.value == 0) {
                  controller.getLocation();
                } else if (homeController.statusPermissionGranted.value == 1) {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return CustomCupertinoAlert(
                        context: context,
                        title: 'location'.tr,
                        content: 'accessLocation'.tr,
                        rightButtonTitle: 'setting'.tr,
                        rightAction: () {
                          AppSettings.openLocationSettings(
                            asAnotherTask: true,
                          );
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 6.w, bottom: 4.h),
                    width: 10.h,
                    height: 10.h,
                    child: Image.asset(ThemeServices().isDarkMode
                        ? AppPath.locationIconDark
                        : AppPath.locationIconLight),
                  ),
                  Expanded(
                    child: Text("nearYou".tr, style: searchScreenTitle),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderListSuggestVendor(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: kDefaultPaddingWidget.h),
      // padding: EdgeInsets.only(bottom: 6.h),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Gợi ý cho bạn",
                  style: searchScreenTitle.copyWith(
                      color: Theme.of(context).primaryColor)),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.listSuggestVendor.length,
            itemBuilder: (context, int index) {
              final VendorModel item = controller.listSuggestVendor[index];

              return Container(
                padding: EdgeInsets.zero,
                child: Hero(
                  tag: "search-${controller.listSuggestVendor[index].id}",
                  child: SearchResultItem(vendorInfo: item, index: index),
                ),
              );
            }),
      ]),
    );
  }

  Widget renderHistorySearch(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: kDefaultPaddingItem.h),
      // padding: EdgeInsets.only(bottom: 6.h),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Tìm kiếm gần đây",
                  style: searchScreenTitle.copyWith(
                      color: Theme.of(context).primaryColor)),
            ),
          ],
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: controller.listSearchHistory.length > 5
                ? 5
                : controller.listSearchHistory.length,
            itemBuilder: (context, int index) {
              final item = controller.listSearchHistory[index];
              return GestureDetector(
                onTap: () {
                  controller.handleSearchVendors(item.t);
                  controller.searchText.value.text = item.t;
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 8.h),
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: controller.listSearchHistory.length !=
                                      index + 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              width: controller.listSearchHistory.length !=
                                      index + 1
                                  ? 0.2.w
                                  : 0))),
                  child: Text(
                    item.t,
                    style: subTitleStyle,
                  ),
                ),
              );
            }),
      ]),
    );
  }

  Widget renderCateogryItem(BuildContext context, String title, String type) {
    return GestureDetector(
      onTap: () {
        controller.category.value = type;
        // controller.handleClearSearch();
        if (type == "") {
          // controller.searchBarTitle.value = 'searchBarTitle'.tr;
          controller.handleChangeCategory('searchBarTitle'.tr);
        } else if (type == CategoryType.bar.getType()) {
          // controller.searchBarTitle.value = "searchBarClubTitle".tr;
          controller.handleChangeCategory("searchBarClubTitle".tr);
        } else if (type == CategoryType.karaoke.getType()) {
          // controller.searchBarTitle.value = "searchKaraokeTitle".tr;
          controller.handleChangeCategory("searchKaraokeTitle".tr);
        } else if (type == CategoryType.massage.getType()) {
          // controller.searchBarTitle.value = "searchMassageTitle".tr;
          controller.handleChangeCategory("searchMassageTitle".tr);
        } else if (type == CategoryType.restaurant.getType()) {
          // controller.searchBarTitle.value = "searchRestaurantTitle".tr;
          controller.handleChangeCategory("searchRestaurantTitle".tr);
        }
      },
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: controller.category.value == type ? 1.w : 0.w,
                      color: controller.category.value == type
                          ? Theme.of(context).primaryColor
                          : Colors.transparent))),
          child: Text(
            title,
            style: TextStyle(
                color: controller.category.value == type
                    ? Theme.of(context).primaryColor
                    : ThemeServices().isDarkMode
                        ? kColorGreyDark
                        : kColorGreyLight),
          )),
    );
  }

  Widget renderSeachBar(
      BuildContext context, SearchController searchController) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        width: double.infinity,
        height: 36.h,
        decoration: BoxDecoration(
          // border: Border.all(color: darkGreyClr.withOpacity(.3), width: 1),
          color:
              ThemeServices().isDarkMode ? Colors.grey[700] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                searchController.dispose();
                context.router.pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
                size: 20.sp,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: TextFormField(
                cursorColor: Theme.of(context).primaryColor,
                autofocus: true,
                onChanged: (text) {
                  if (text != "") {
                    searchController.handleSearchVendors(text);
                  } else if (text == "") {
                    searchController.handleClearSearch();
                  }
                },
                style: AppTextStyle().subtitleRegular14.copyWith(height: 1.2),
                controller: searchController.searchText.value,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: controller.searchBarTitle.value,
                ),
              ),
            ),
            Visibility(
                visible: controller.searchText.value.text != "",
                child: GestureDetector(
                  onTap: () {
                    controller.handleClearData();
                  },
                  child: Icon(
                    Ionicons.close_circle_outline,
                    color: Theme.of(context).primaryColor,
                    size: 16.sp,
                  ),
                ))
          ],
        ));
  }
}

Widget renderPopularCity(BuildContext context, SearchController controller) {
  return Container(
    padding: EdgeInsets.only(top: 0.h),
    child: Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text("favoritePlace".tr,
              style: searchScreenTitle.copyWith(
                  color: Theme.of(context).primaryColor)),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 8.h),
          height: 80.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.listCity.length,
            itemBuilder: (ctx, index) {
              final cityInfo = controller.listCity[index];
              return PopularPlaceWidget(
                  placeCount: cityInfo.placeCount ?? 100,
                  imageSize: 65.h,
                  cityCode: cityInfo.code ?? "",
                  placeImage: cityInfo.categoryImage ??
                      "assets/images/place/saigon.jpg",
                  placeTitle: cityInfo.title ?? "Hà Nội");
            },
          ),
        ),
      ],
    ),
  );
}

Widget renderRecentSearch(BuildContext context,
    List<SearchRecentModel> listRecentSearch, SearchController controller) {
  final HomeController homeController =
      Get.put(HomeController(getIt.get<ApiClient>()));

  return Container(
    margin: const EdgeInsets.only(top: kDefaultPaddingItem * 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (homeController.statusPermissionGranted.value == 0) {
                    controller.getLocation();
                  } else if (homeController.statusPermissionGranted.value ==
                      1) {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext dialogContext) {
                        return CustomCupertinoAlert(
                          context: context,
                          title: 'location'.tr,
                          content: 'accessLocation'.tr,
                          rightButtonTitle: 'setting'.tr,
                          rightAction: () {
                            AppSettings.openLocationSettings(
                              asAnotherTask: true,
                            );
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_sharp,
                      color: HexColor("#F0B92B"),
                      size: 24.sp,
                    ),
                    SizedBox(width: defaultPaddingItem.w),
                    Expanded(
                      child: Text("nearYou".tr,
                          style: searchScreenTitle.copyWith(
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ))),
        SizedBox(
          height: kDefaultPaddingWidget.h * 1.5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text("recentSearch".tr, style: searchScreenTitle),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: listRecentSearch.length,
            itemBuilder: (context, int index) {
              final SearchRecentModel item = listRecentSearch[index];
              return SearchItem(index: index, item: item);
            })
      ],
    ),
  );
}

Widget renderFavoritePlace(
    BuildContext context, List<FavoritePlaceModel> listFavoritePlace) {
  return Container(
    margin: const EdgeInsets.only(top: kDefaultPaddingItem * 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("favoritePlace".tr, style: searchScreenTitle),
        ),
        SizedBox(
          height: kDefaultPaddingWidget.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: listFavoritePlace.length,
            itemBuilder: (context, int index) {
              final FavoritePlaceModel item = listFavoritePlace[index];
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                margin: EdgeInsets.only(
                    top: index > 0 ? kDefaultPaddingWidget.h : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star_border_sharp,
                      size: 26.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: kDefaultPaddingWidget.w,
                    ),
                    Text(
                      item.placeName,
                      style: searchRecentTitle,
                    ),
                  ],
                ),
              );
            })
      ],
    ),
  );
}
