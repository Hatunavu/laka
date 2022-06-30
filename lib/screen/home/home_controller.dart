import 'dart:developer';
import 'dart:convert';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/category/category_model.dart';
import 'package:client_tggt/model/category/city_model.dart';
import 'package:client_tggt/model/category/home_splash_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as geoLocation;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_version/new_version.dart';
import 'package:path/path.dart';

class HomeController extends GetxController {
  final RxString title = "home".obs;
  final isLoading = false.obs;
  final listCategory = <CategoryModel>[].obs;
  // final listHotServices = <VendorModel>[].obs;
  RxList<VendorModel> listHotServices = RxList<VendorModel>();
  final moreHostVendors = <VendorModel>[].obs;

  final listSuggestedServices = <VendorModel>[].obs;
  final listProvinces = <ProvinceData>[].obs;
  final selectedProvince = ProvinceData().obs;

  final listOrder = <BookingItemModel>[].obs;
  final appVersion = "0.0".obs;

  final listCity = <CityModel>[].obs;
  HomeController(this._apiClient);
  final ApiClient _apiClient;
  final currentAddress = "Hà Nội".obs;
  final latitude = defaultLat.obs;
  final longitude = defaultLng.obs;
  final cityCode = "01".obs;

  // ignore: prefer_const_constructors
  final currentLocation = LatLng(21.0208823, 105.8499577).obs;
  final statusPermissionGranted = 0.obs;
  ScrollController scrollController = ScrollController();
  final backgroundColorBehind = ThemeServices().isDarkMode
      ? kColorPrimaryDark.obs
      : kColorPrimaryLight.obs;
  final carouselIndex = 0.obs;
  final listSplashImage = <HomeSplashMode>[].obs;
  final listBanners = <BannerModel>[].obs;
  final page = 1.obs;
  final totalDocs = 0.obs;
  final totalPage = 1.obs;
  final isLoadingMore = false.obs;
  final isFirst = true.obs;
  final hasMore = 0.obs;
  @override
  void onReady() {
    scrollController.addListener(listenScroll);
    super.onReady();
  }

  @override
  Future<void> onInit() async {
    final isFirstBuild = AccountServices().getIsFirstBuild();
    if (isFirstBuild == true) {
      AccountServices().saveIsFirstBuild(false);
      getDataHomeScreen();
    } else {
      getLocation();
    }
    handleAddListCity();
    addListSplashImage();

    super.onInit();
  }

  handleGetDataHomeScreen(BuildContext context) async {
    final isFirstBuild = AccountServices().getIsFirstBuild();
    if (isFirstBuild == true) {
      AccountServices().saveIsFirstBuild(false);
      getDataHomeScreen();
    } else {
      getLocation();
    }
    handleAddListCity();
    addListSplashImage();
  }

  handleUpdateCarouselIndex(int index) {
    carouselIndex.value = index;
  }

  addListSplashImage() {
    listSplashImage.add(HomeSplashMode(
        index: 0, image: "assets/images/banner/Banner-LAKA-01.jpg"));
    listSplashImage.add(HomeSplashMode(
        index: 1, image: "assets/images/banner/Banner-LAKA-02.jpg"));
  }

  listenScroll() {
    if (scrollController.offset < 0) {
      backgroundColorBehind.value =
          ThemeServices().isDarkMode ? kColorPrimaryDark : kColorPrimaryLight;
    } else {
      backgroundColorBehind.value = ThemeServices().isDarkMode
          ? kColorBackgroundDark
          : kColorBackgroundLight;
    }

    // print((scrollController.position.maxScrollExtent / page.value) /
    //     listHotServices.length);
    var checkPosition =
        (scrollController.position.maxScrollExtent / page.value) /
            listHotServices.length;

    if ((scrollController.position.pixels >
            (scrollController.position.maxScrollExtent -
                (checkPosition * 5))) &&
        (scrollController.position.pixels <
            (scrollController.position.maxScrollExtent -
                (checkPosition * 4)))) {
      if (totalDocs.value == 0) {
        if (isLoadingMore.isFalse) {
          getMoreHotVendor();
        }
      }
      if (moreHostVendors.length < totalDocs.value) {
        if (isLoadingMore.isFalse) {
          getMoreHotVendor();
        }
      }
    }
  }

  handleAddListCity() {
    listCity.add(CityModel(
        title: "Hà Nội",
        categoryImage: AppPath.placeHaNoi,
        placeCount: 68,
        code: "01"));
    listCity.add(CityModel(
        title: "Sài Gòn",
        categoryImage: AppPath.placehcm,
        code: "79",
        placeCount: 100));
    listCity.add(CityModel(
        title: "Hải Phòng",
        categoryImage: AppPath.placeHaiPhong,
        code: "31",
        placeCount: 86));
    listCity.add(CityModel(
        title: "Đà Nẵng",
        categoryImage: AppPath.placeDaNang,
        placeCount: 86,
        code: "48"));
    listCity.add(CityModel(
        title: "Huế",
        categoryImage: AppPath.placehue,
        placeCount: 86,
        code: "46"));
    listCity.add(CityModel(
        title: "Nha Trang",
        categoryImage: AppPath.placekhanhhoa,
        code: "56",
        placeCount: 86));
    listCity.add(CityModel(
        title: "Hạ Long",
        categoryImage: AppPath.placeQuangNinh,
        placeCount: 86,
        code: "22"));
    listCity.add(CityModel(
        title: "Hội An",
        categoryImage: AppPath.placeHoiAn,
        placeCount: 86,
        code: "49"));
    listCity.add(CityModel(
        title: "Phú Yên",
        categoryImage: AppPath.placePhuYen,
        placeCount: 86,
        code: "54"));
    listCity.add(CityModel(
        title: "Vũng Tàu",
        categoryImage: AppPath.placeVungTau,
        placeCount: 86,
        code: "77"));
  }

  getLocation() {
    _getLocation().then((value) {
      if (value != null) {
        LocationData? location = value;
        getDataHomeScreen(lat: location.latitude, lng: location.longitude);
        _getAddress(location.latitude, location.longitude).then((value) {
          if (value != "") {
            currentAddress.value = value;
            AccountServices().saveAccountAdress(value);
          }

          currentLocation.value = LatLng(
              location.latitude ?? currentLocation.value.latitude,
              location.longitude ?? currentLocation.value.longitude);
          longitude.value = (location.longitude ?? 21.0208823).toString();
          latitude.value = (location.latitude ?? 21.0208823).toString();
          final MainController mainController = Get.find();
          mainController.handleUpdateLocation(
              (location.latitude ?? 21.0208823).toString(),
              (location.longitude ?? 21.0208823).toString());
        });
      } else {
        getDataHomeScreen();
      }
    });
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    try {
      List<geoLocation.Placemark> placemarks =
          await geoLocation.placemarkFromCoordinates(lat, lang);
      var currentAddress = "${placemarks[0].locality}";

      if (currentAddress == "") {
        return placemarks[0].locality ?? "";
      } else {
        return currentAddress;
      }
    } catch (e) {
      return "";
    }
  }

  checkVersion(BuildContext context) async {
    final newVersion = NewVersion(
        androidId: "vn.com.laka.mobile", iOSId: "vn.com.laka.mobile");
    final status = await newVersion.getVersionStatus();
    if (status == null) return;
    return newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: "notification".tr,
        dialogText: "lakaUpdate".tr,
        dismissButtonText: "skip".tr,
        updateButtonText: "update".tr,
        dismissAction: () {
          Navigator.pop(context);
        });
  }

  Future<LocationData?> _getLocation() async {
    try {
      isLoading.value = true;
      Location location = Location();
      LocationData _locationData;

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        getDataHomeScreen();
        return null;
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          statusPermissionGranted.value = 1;
          getDataHomeScreen();
          return null;
        }
      }

      statusPermissionGranted.value = 0;

      _locationData = await location.getLocation();
      return _locationData;
    } on Exception catch (err) {
      debugPrint("err $err");
    } finally {
      debugPrint("finally");
    }
  }

  getDataHomeScreen({double? lat, double? lng}) async {
    try {
      final myLat = lat == null ? defaultLat : lat.toString();
      final myLng = lng == null ? defaultLng : lng.toString();
      final response = await _apiClient.getHotAndSuggestVendor(myLat, myLng);
      listHotServices.value = response.data?.hotVendors ?? listHotServices;
      listSuggestedServices.value =
          response.data?.suggestedVendors ?? listHotServices;
      listBanners.value = response.data?.banners ?? [];
      isLoading(false);
      getListProvinces();
    } on Exception catch (err) {
      log("err $err");
      isLoading(false);
    }
  }

  getMoreHotVendor() async {
    try {
      isLoadingMore.value = true;
      hasMore.value = 0;
      final newPage = page.value + 1;
      page.value = newPage;
      final response = await _apiClient.getMoreHotVendor(
          newPage.toString(), longitude.value, latitude.value);
      if (response.status == 200) {
        final data = response.data;
        if (totalDocs.value == 0) {
          totalDocs.value = data.totalDocs == null
              ? 0
              : data.totalDocs! > 100
                  ? 100
                  : data.totalDocs!;
        }

        moreHostVendors.value = moreHostVendors.isEmpty
            ? data.docs ?? []
            : [...moreHostVendors, ...data.docs ?? []];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingMore.value = false;
    }
  }

  final assetKey = 'assets/provinces.json';

  Future<List<ProvinceData>?> getProvince() async {
    try {
      final json = await rootBundle.loadString(assetKey);
      final res = jsonDecode(json);

      List data = res['data'];

      return data.map((json) => ProvinceData.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  getListProvinces() async {
    try {
      var data = await getProvince();
      if (data != null) {
        final findProvinceByText = data
            .where((element) => element.name!.contains(currentAddress.value))
            .toList();
        if (findProvinceByText.isNotEmpty) {
          cityCode.value = findProvinceByText[0].code ?? "01";
          selectedProvince.value = findProvinceByText[0];
          final MainController mainController = Get.find();
          mainController
              .handleUpdateCityCode(findProvinceByText[0].code ?? "01");
        }

        listProvinces.value = data;
      }
    } on Exception catch (err) {
      log("err $err");
    }
  }

  handleUpdateSelectedProvince(ProvinceData data) {
    selectedProvince.value = data;
    cityCode.value = data.code ?? "01";
    final MainController mainController = Get.find();
    mainController.handleUpdateCityCode(data.code ?? "01");
    var cityName = data.name ?? "";
    if (cityName.contains("Thành phố")) {
      currentAddress.value = cityName.replaceAll("Thành phố", "");
    } else if (cityName.contains("Tỉnh")) {
      currentAddress.value = cityName.replaceAll("Tỉnh", "");
    } else {
      currentAddress.value = cityName;
    }
  }
}
