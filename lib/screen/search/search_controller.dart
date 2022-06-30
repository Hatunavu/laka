import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/model/category/city_model.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/debounce.dart';
import 'package:client_tggt/model/search/favorite_place_model.dart';
import 'package:client_tggt/model/search/history/history_search_response.dart';
import 'package:client_tggt/model/search/search_recent_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class SearchController extends GetxController {
  final RxString title = "search".obs;
  RxList<SearchRecentModel> listSeachRecent = RxList<SearchRecentModel>();
  RxList<FavoritePlaceModel> listFavoritePlace = RxList<FavoritePlaceModel>();
  List<CityModel> listCity = <CityModel>[].obs;
  final category = "".obs;
  final searchText = TextEditingController(text: "").obs;
  final isLoading = false.obs;
  final latitude = "".obs;
  final longitude = "".obs;
  final isEmptyResult = false.obs;
  final _debounce = Debounce(milliseconds: 700);
  final _debounceClear = Debounce(milliseconds: 1500);

  final searchBarTitle = "".obs;
  final isLoadingHistory = false.obs;
  final listSearchHistory = <HistorySearchModel>[].obs;
  final listSuggestVendor = <VendorModel>[].obs;

  // List<VendorInfoModel> listSearchResult = <VendorInfoModel>[].obs;
  final listSearchResult = <VendorModel>[].obs;
  final isSearchStatus = 0.obs;
  SearchController(this._apiClient);
  final ApiClient _apiClient;
  @override
  void onInit() {
    super.onInit();
    final MainController mainController = Get.find();
    final lat = mainController.latitude.value;
    final lng = mainController.longitude.value;
    latitude.value = lat;
    longitude.value = lng;
    addListSearch();
    handleAddListCity();
    addListFavoritePlace();
    getSearchHistory();
  }

  getSearchHistory() async {
    try {
      isLoadingHistory(true);
      var response = await _apiClient.getSearchHistory();

      if (response.status == 200) {
        final data = response.data;
        listSearchHistory.value = data!.searches ?? [];
        listSuggestVendor.value = data.suggestedVendors;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingHistory(false);
    }
  }

  handleChangeCategory(String category) {
    searchBarTitle.value = category;
  }

  handleAddListCity() {
    listCity.add(CityModel(
        title: "Hà Nội",
        categoryImage: AppPath.placeHaNoi,
        placeCount: 68,
        code: "01"));
    listCity.add(CityModel(
        title: "Hồ Chí Minh",
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
        title: "Khánh Hoà",
        categoryImage: AppPath.placekhanhhoa,
        code: "56",
        placeCount: 86));
    listCity.add(CityModel(
        title: "Quảng Ninh",
        categoryImage: AppPath.placeQuangNinh,
        placeCount: 86,
        code: "22"));
  }

  final listCategory = [
    "all".tr,
    CategoryType.restaurant.display(),
    CategoryType.karaoke.display(),
    CategoryType.bar.display(),
    CategoryType.massage.display()
  ];

  getLocation() async {
    try {
      isLoading(true);
      isEmptyResult(false);
      // var response = await _apiClient.getVendorByLocation(latt, lng);
      // var response = await _apiClient.getSearchVendors(
      //     category.value, "", "", lng, lat);
      var response = await _apiClient.getFilterVendor("", "", longitude.value,
          latitude.value, 20, 1, "", "", category.value, "", "", "", "");
      if (response.status == 200) {
        listSearchResult.value = response.data.docs ?? [];
        if (listSearchResult.isEmpty) {
          isEmptyResult(true);
        }
      } else {
        log("da co loi xay ra");
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleClearData() {
    searchText.value.text = "";
    isSearchStatus.value = 0;
    isEmptyResult.value = false;
    listSearchResult.value = [];
    _debounceClear.dispose();
  }

  handleClearSearch() {
    _debounce.dispose();
    _debounceClear.run(() {
      searchText.value.text = "";
      isSearchStatus.value = 0;
      isEmptyResult.value = false;
      listSearchResult.value = [];
      _debounceClear.dispose();
    });
  }

  handleSearchVendors(String text) {
    _debounceClear.dispose();
    _debounce.run(() async {
      try {
        isEmptyResult(false);
        isLoading(true);
        isSearchStatus.value = 0;
        // var response = await _apiClient.getVendorByText(text);
        // var response =
        //     await _apiClient.getSearchVendors(category.value, "", text, "", "");
        var response = await _apiClient.getFilterVendor(
            "",
            text,
            longitude.value,
            latitude.value,
            20,
            1,
            "",
            "",
            category.value,
            "",
            "",
            "",
            "");
        if (response.status == 200) {
          listSearchResult.value = response.data.docs!;
          if (response.data.docs!.isEmpty) {
            isEmptyResult(true);
            isSearchStatus.value = 1;
          }
        } else {
          log("da co loi xay ra");
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    });
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    LocationData _locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  addListSearch() {
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.bar,
        ventorName: "New Square Club",
        ventorAddress: "QL32, Đức Thượng, Hoài Đức, Hà Nội"));
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.karaoke,
        ventorName: "Crown karaoke",
        ventorAddress: "130 Hồ Tùng Mậu, Cầu Giấy, Hà Nội"));
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.massage,
        ventorName: "Massage Tâm Sen",
        ventorAddress: "Violet 4 Vinhomes Gardenia, Nam Từ Liêm, Hà Nội"));
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.restaurant,
        ventorName: "Nhà hàng Thu Hằng",
        ventorAddress: "170 Cầu Diễn, Bắc Từ Liêm, Hà Nội"));
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.bar,
        ventorName: "1900 Le Théâtre",
        ventorAddress: "8B Tạ Hiện, Hàng Buồm, Hoàn Kiếm, Hà Nội"));
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.bar,
        ventorName: "New Square Club",
        ventorAddress: "QL32, Đức Thượng, Hoài Đức, Hà Nội"));
    listSeachRecent.add(SearchRecentModel(
        category: CategoryType.karaoke,
        ventorName: "Crown karaoke",
        ventorAddress: "130 Hồ Tùng Mậu, Cầu Giấy, Hà Nội"));
  }

  addListFavoritePlace() {
    listFavoritePlace.add(FavoritePlaceModel(placeName: "Hà Nội"));
    listFavoritePlace.add(FavoritePlaceModel(placeName: "Đà Nẵng"));
    listFavoritePlace.add(FavoritePlaceModel(placeName: "Hải Phòng"));
  }

  @override
  void dispose() {
    _debounce.dispose();
    _debounceClear.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    _debounce.dispose();
    _debounceClear.dispose();

    FocusManager.instance.primaryFocus?.unfocus();
    super.onClose();
  }
}
