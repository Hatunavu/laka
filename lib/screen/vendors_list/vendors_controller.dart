import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/category/home_splash_model.dart';
import 'package:client_tggt/model/search/filter/price_range_model.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/tagline_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/home/widget/category_widget.dart';
import 'package:client_tggt/screen/home/widget/vendor_item.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/vendors_list/widgets/filter_chip_item/filter_chip_item_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorsController extends GetxController {
  late GoogleMapController mapController;
  late BuildContext context;
  var listMarker = <Marker>{}.obs;
  var listSuggestedServices = <VendorModel>[].obs;
  var listRecommendVendors = <VendorModel>[].obs;
  // var listBanners = <GalleryModel>[].obs;
  var categoryName = "".obs;
  var category = "".obs;
  final isSelectAll = true.obs;
  final isSelect = false.obs;
  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final isEmpty = false.obs;
  var isMapExpanded = false.obs;
  final isVisible = true.obs;
  final selectedPriceRange = PriceRangeModel(min: "0", max: "0", title: "").obs;
  final textSearch = "".obs;
  final cityCode = "".obs;
  final attributeString = "".obs;
  final minPrice = "".obs;
  final maxPrice = "".obs;
  final limit = 20.obs;
  final page = 1.obs;
  final categoriesString = "".obs;
  final provinceString = "".obs;
  final districtString = "".obs;
  final tagLineString = "".obs;
  final varientString = "".obs;
  // ignore: prefer_const_constructors
  var currentLocation = LatLng(21.00198007320593, 105.84499934842783).obs;
  var latitude = "".obs;
  var longitude = "".obs;
  final listSelectedAttribute = <AttributeModel>[].obs;
  final listAttribute = <AttributeModel>[].obs;
  final listProvinces = <ProvinceData>[].obs;
  final listDistricts = <DistrictData>[].obs;
  final selectedDistrics = DistrictData().obs;
  final dataKey = GlobalKey();

  final selectedProvince = ProvinceData().obs;
  final ApiClient _apiClient;
  final isFetchAttributeSuccess = false.obs;
  ScrollController controller = ScrollController();
  final listPrice = <PriceRangeModel>[].obs;
  final listTagline = <TaglineModel>[].obs;
  final selectedTaglines = TaglineModel(id: "", name: "", type: "").obs;
  final listVariant = <VariantModel>[].obs;
  final selectedVariant =
      VariantModel(id: "", name: "", category: CategoryType.karaoke).obs;

  final listBanners = <BannerModel>[].obs;
  final carouselIndex = 0.obs;
  final searchTextController = TextEditingController(text: "").obs;

  var scrollController = ScrollController().obs;
  var posterScrollController = ScrollController().obs;

  ScrollController vendorListController = ScrollController();

  var isPinned = false.obs;
  var isAutoSwipper = true.obs;
  final isLoadingPoster = false.obs;
  VendorsController(this._apiClient);
  final totalDocs = 0.obs;
  final isPin = false.obs;
  select() => isSelect.value = !isSelect.value;

  setCategory(CategoryType category) async {
    this.category.value = category.getType();
    categoryName.value = category.display();
    categoriesString.value = category.getType();
    switch (category) {
      case CategoryType.bar:
        listPrice.value = [
          PriceRangeModel(min: "0", max: "300000", title: "Dưới 300k"),
          PriceRangeModel(min: "300000", max: "1000000", title: "300k - 1tr"),
          PriceRangeModel(min: "1000000", max: "100000000", title: "Trên 1tr"),
        ];

        break;
      case CategoryType.karaoke:
        listPrice.value = [
          PriceRangeModel(min: "0", max: "500000", title: "Dưới 500k"),
          PriceRangeModel(min: "500000", max: "1000000", title: "500k - 1tr"),
          PriceRangeModel(min: "1000000", max: "100000000", title: "Trên 1tr"),
        ];

        break;
      case CategoryType.massage:
        listPrice.value = [
          PriceRangeModel(min: "500000", max: "1000000", title: "500k - 1tr"),
          PriceRangeModel(min: "1000000", max: "3000000", title: "1tr - 3tr"),
          PriceRangeModel(min: "3000000", max: "100000000", title: "Trên 3tr"),
        ];

        break;
      case CategoryType.restaurant:
        listPrice.value = [
          PriceRangeModel(min: "200000", max: "500000", title: "200k - 500k"),
          PriceRangeModel(min: "500000", max: "1000000", title: "500k - 1tr"),
          PriceRangeModel(min: "1000000", max: "100000000", title: "Trên 1tr"),
        ];
        break;
      default:
    }

    // Future.wait([getLocation(), handleGetPoster(category)]);
  }

  @override
  void onInit() {
    Get.create<FilterChipItemController>(() => FilterChipItemController());
    controller.addListener(listen);

    scrollController.value.addListener(() {
      if (!isPinned.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset > 410.h) {
        isPinned.value = true;
      } else if (isPinned.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset < 410.h) {
        isPinned.value = false;
      }

      if (isAutoSwipper.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset > 0.h) {
        isAutoSwipper.value = false;
      } else if (!isAutoSwipper.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset == 0) {
        isAutoSwipper.value = true;
      }

      // if (scrollController.value.offset ==
      //     scrollController.value.position.maxScrollExtent) {
      //   if (listSuggestedServices.length < totalDocs.value) {
      //     handleGetMoreVendors();
      //   }
      // }

      var checkPosition =
          (scrollController.value.position.maxScrollExtent / page.value) /
              listSuggestedServices.length;
      if ((scrollController.value.position.pixels >
              (scrollController.value.position.maxScrollExtent -
                  (checkPosition * 5))) &&
          (scrollController.value.position.pixels <
              (scrollController.value.position.maxScrollExtent -
                  (checkPosition * 4)))) {
        if (listSuggestedServices.length < totalDocs.value) {
          if (isLoadMore.isFalse) {
            handleGetMoreVendors();
          }
        }
      }

      if (isPin.value == false) {
        if (scrollController.value.offset >
            (MediaQuery.of(context).size.height - 50.h)) {
          isPin.value = true;
        }
      }
      if (isPin.value == true) {
        if (scrollController.value.offset <
            (MediaQuery.of(context).size.height - 50.h)) {
          isPin.value = false;
        }
      }
    });
    super.onInit();
  }

  Future<void> handleGetPoster(CategoryType category) async {
    try {
      isLoadingPoster(true);
      HomeController homeController = Get.find();
      currentLocation = homeController.currentLocation;
      if (homeController.currentLocation.value == const LatLng(0, 0)) {
        homeController.currentLocation.value =
            const LatLng(21.0208823, 105.8499577);
      }
      currentLocation = homeController.currentLocation;

      final lat = currentLocation.value.latitude.toString();
      final lng = currentLocation.value.longitude.toString();
      latitude.value = lat;
      longitude.value = lng;
      var response =
          await _apiClient.getVendorsPoster(category.getType(), 1, lng, lat);
      if (response.status == 200) {
        listRecommendVendors.value = response.data.recommendVendors ?? [];
        listBanners.value = response.data.banners ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingPoster(false);
    }
  }

  // @override
  // void onReady() {
  //   getListAttribute();
  //   super.onReady();
  // }

  listen() {
    final direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  getListProvinces() async {
    try {
      var response = await _apiClient.getProvinces();
      if (response.status == 200) {
        if (response.data != null) {
          listProvinces.value = response.data ?? listProvinces;
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  Future<void> getListAttribute() async {
    try {
      var response = await _apiClient.customerGetListAttribute();
      if (response.status == 200) {
        listAttribute.value = response.data ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isFetchAttributeSuccess.value = true;
    }
  }

  Future<void> getListTagsLine(CategoryType category) async {
    try {
      var response =
          await _apiClient.getListTaglinesByCategory(category.getType());
      if (response.status == 200) {
        listTagline.value = response.data;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isFetchAttributeSuccess.value = true;
    }
  }

  Future<void> getListSubCategory(CategoryType category) async {
    try {
      var response = await _apiClient.getListSubCategory(category.getType());
      if (response.status == 200) {
        listVariant.value = response.data;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isFetchAttributeSuccess.value = true;
    }
  }

  selectAll() {
    isSelectAll.value = !isSelectAll.value;
  }

  show() {
    if (isVisible.isFalse) {
      isVisible.value = true;
    }
  }

  hide() {
    if (isVisible.isTrue) {
      isVisible.value = false;
    }
  }

  _addMarker() async {
    // ignore: invalid_use_of_protected_member
    final locationIcon = ThemeServices().isDarkMode
        ? AppPath.locationIconDark
        : AppPath.locationIconLight;
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(6.w, 6.h)),
      locationIcon,
    );
    listMarker.value = {};
    for (var item in listSuggestedServices) {
      final lng = item.address.location.coordinates?.first ?? 0;
      final lat = item.address.location.coordinates?.last ?? 0;
      final latLng = LatLng(lat, lng);
      var markerIdVal = item.id;
      final MarkerId markerId = MarkerId(markerIdVal ?? '');
      final Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
          title: item.brandName,
        ),
        icon: markerbitmap,
        onTap: () {
          showDialog(
            useRootNavigator: true,
            context: context,
            barrierColor: Colors.transparent,
            builder: (context) => Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 210.h,
                width: (MediaQuery.of(context).size.width * 0.75).w,
                child: Hero(
                  tag: "map-${item.id}",
                  child: VendorItem(
                    listType: "map",
                    price: item.priceRange.toString(),
                    vendorInfo: item,
                  ),
                ),
              ),
            ),
          );
        },
      );
      listMarker.add(marker);
    }
    listMarker.refresh();
  }

  Future<void> getLocation(CategoryType category) async {
    isLoading(true);
    // HomeController homeController = Get.find();
    // currentLocation = homeController.currentLocation;
    // if (homeController.currentLocation.value == const LatLng(0, 0)) {
    //   homeController.currentLocation.value =
    //       const LatLng(21.0208823, 105.8499577);
    // }
    // currentLocation = homeController.currentLocation;

    // final lat = currentLocation.value.latitude.toString();
    // final lng = currentLocation.value.longitude.toString();
    // latitude.value = lat;
    // longitude.value = lng;
    final MainController mainController = Get.find();
    final lat = mainController.latitude.value;
    final lng = mainController.longitude.value;
    final code = mainController.currentCityCode.value;
    longitude.value = lng;
    latitude.value = lat;
    cityCode.value = code;
    provinceString.value = code;

    handleFilterVendor(
      attributeString.value,
      lng,
      lat,
      minPrice.value,
      maxPrice.value,
      category.getType(),
      code,
      districtString.value,
      tagLineString.value,
      varientString.value,
    );

    Future.wait([getListDistrictByProvinceID(code), getListAttribute()]);
  }

  Future<void> getListDistrictByProvinceID(String provinceID) async {
    try {
      isLoading.value = true;
      var response = await _apiClient.getDistrictsByProvince(provinceID);
      if (response.status == 200) {
        if (response.data != null) {
          listDistricts.value = response.data ?? [];
        }
      } else {
        //errorMessage.value = "Số điện thoại đã tồn tại.";
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading.value = false;
    }
  }

  handleFilterVendor(
      String attributes,
      String lng,
      String lat,
      String minPrice,
      String maxPrice,
      String categories,
      String cityCode,
      String districtCode,
      String tagline,
      String variant) async {
    try {
      isLoading(true);
      var response = await _apiClient.getFilterVendor(
          attributes,
          searchTextController.value.text,
          lng,
          lat,
          limit.value,
          1,
          minPrice,
          maxPrice,
          categories,
          cityCode,
          districtCode,
          tagline,
          variant);
      if (response.status == 200) {
        listSuggestedServices.value = response.data.docs!;
        if (totalDocs.value == 0) {
          totalDocs.value = response.data.totalDocs ?? 0;
        }
        page.value = 1;
        if (response.data.docs!.isEmpty) {
          isEmpty(true);
        } else {
          isEmpty(false);

          _addMarker();
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleGetMoreVendors() async {
    final newPage = page.value + 1;
    page.value = newPage;
    isLoadMore.value = true;
    try {
      var response = await _apiClient.getFilterVendor(
          attributeString.value,
          textSearch.value,
          longitude.value,
          latitude.value,
          limit.value,
          newPage,
          minPrice.value,
          maxPrice.value,
          categoriesString.value,
          cityCode.value,
          districtString.value,
          tagLineString.value,
          varientString.value);
      if (response.status == 200) {
        final data = response.data.docs ?? [];
        listSuggestedServices.value = [...listSuggestedServices, ...data];
        if (response.data.docs!.isEmpty) {
          isEmpty(true);
        } else {
          isEmpty(true);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadMore.value = false;
    }
  }

  handleSearchText() async {
    try {
      isLoading(true);
      var response = await _apiClient.getFilterVendor(
          "",
          searchTextController.value.text,
          "",
          "",
          limit.value,
          page.value,
          "",
          "",
          categoriesString.value,
          "",
          "",
          "",
          "");
      if (response.status == 200) {
        selectedPriceRange.value =
            PriceRangeModel(min: "0", max: "0", title: "");
        minPrice.value = "";
        maxPrice.value = "";
        listSelectedAttribute.value = [];
        attributeString.value = "";
        listSuggestedServices.value = response.data.docs!;
        selectedProvince.value = ProvinceData();
        provinceString.value = "";
        if (response.data.docs!.isEmpty) {
          isEmpty(true);
        } else {
          isEmpty(false);
          // _addMarker();
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  changeCurrentLocationCamera() {
    mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation.value, zoom: 12)));
  }

  handleUpdateSelectedPriceRange(PriceRangeModel priceRange) {
    selectedPriceRange.value = priceRange;
    if (priceRange.title == "") {
      minPrice.value = "";
      maxPrice.value = "";
    } else {
      minPrice.value = priceRange.min;
      maxPrice.value = priceRange.max;
    }

    handleFilterVendor(
        attributeString.value,
        longitude.value,
        latitude.value,
        priceRange.title == "" ? "" : priceRange.min,
        priceRange.title == "" ? "" : priceRange.max,
        categoriesString.value,
        provinceString.value,
        districtString.value,
        tagLineString.value,
        varientString.value);
  }

  handleUpdateListAttribute(List<AttributeModel> attributes) {
    listSelectedAttribute.value = attributes;
    var attributesListString = "";
    for (var element in attributes) {
      if (attributesListString == "") {
        attributesListString = element.id!;
      } else {
        attributesListString = attributesListString + "," + element.id!;
      }
    }

    attributeString.value = attributesListString;
    handleFilterVendor(
        attributesListString,
        longitude.value,
        latitude.value,
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        provinceString.value,
        districtString.value,
        tagLineString.value,
        varientString.value);
  }

  handleUpdateSelectedDistrict(DistrictData data) {
    selectedDistrics.value = data;
    var getDistrictString = "";
    if (data.name != null) {
      districtString.value = data.code ?? "";
      getDistrictString = data.code ?? "";
    } else {
      districtString.value = "";
    }
    handleFilterVendor(
        attributeString.value,
        longitude.value,
        latitude.value,
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        cityCode.value,
        getDistrictString,
        tagLineString.value,
        varientString.value);
  }

  handleUpdateSelectedTaglines(TaglineModel data) {
    selectedTaglines.value = data;
    if (data.name != "") {
      tagLineString.value = data.id;
    } else {
      provinceString.value = "";
    }
    handleFilterVendor(
        attributeString.value,
        longitude.value,
        latitude.value,
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        provinceString.value,
        districtString.value,
        data.id,
        varientString.value);
  }

  handleUpdateSelectedVariant(VariantModel data) {
    selectedVariant.value = data;
    if (data.name != "") {
      varientString.value = data.id;
    } else {
      varientString.value = "";
    }
    handleFilterVendor(
        attributeString.value,
        longitude.value,
        latitude.value,
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        provinceString.value,
        districtString.value,
        tagLineString.value,
        data.id);
  }
}
