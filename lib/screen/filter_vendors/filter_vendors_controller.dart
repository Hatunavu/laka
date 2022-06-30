import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/search/filter/price_range_model.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class FilterVendorsController extends GetxController {
  final String title = "message";
  final category = "KARAOKE".obs;
  final isLoading = false.obs;
  final ApiClient _apiClient;
  final isEmptyResult = false.obs;
  final isFetchAttributeSuccess = false.obs;

  RxList<VendorModel> listVendors = RxList<VendorModel>();
  ScrollController controller = ScrollController();
  final isVisible = true.obs;
  FilterVendorsController(this._apiClient);
  RxList<CategoryType> selectedCategory = RxList<CategoryType>();
  final selectedPriceRange = PriceRangeModel(min: "0", max: "0", title: "").obs;
  final listAttribute = <AttributeModel>[].obs;
  final listSelectedAttribute = <AttributeModel>[].obs;
  final listProvinces = <ProvinceData>[].obs;
  final selectedProvince = ProvinceData().obs;
  final listDistricts = <DistrictData>[].obs;
  final selectedDistrics = DistrictData().obs;
  final isFilterCity = false.obs;
  final cityCode = "".obs;
  final attributeString = "".obs;
  final minPrice = "".obs;
  final maxPrice = "".obs;
  final limit = 20.obs;
  final lat = "".obs;
  final lng = "".obs;
  final page = 1.obs;
  final totalDocs = 0.obs;
  final categoriesString = "".obs;
  final provinceString = "".obs;
  final districtString = "".obs;
  final varientString = "".obs;

  final listVariant = <VariantModel>[].obs;
  final selectedVariant =
      VariantModel(id: "", name: "", category: CategoryType.karaoke).obs;
  final List<PriceRangeModel> listPrice = [
    PriceRangeModel(min: "0", max: "500000", title: "0 - 500k"),
    PriceRangeModel(min: "500000", max: "1000000", title: "500K - 1TR"),
    PriceRangeModel(min: "1000000", max: "2000000", title: "1TR - 2TR"),
    PriceRangeModel(min: "2000000", max: "3000000", title: "2TR - 3TR"),
    PriceRangeModel(min: "3000000", max: "4000000", title: "3TR - 4TR"),
    PriceRangeModel(min: "4000000", max: "5000000", title: "4TR - 5TR"),
    PriceRangeModel(min: "5000000", max: "10000000", title: "5TR - 10TR"),
    PriceRangeModel(min: "10000000", max: "20000000", title: "10TR - 20TR"),
    PriceRangeModel(min: "20000000", max: "500000000", title: "> 20TR"),
  ];

  final List<CategoryType> listCategory = [
    CategoryType.bar,
    CategoryType.karaoke,
    CategoryType.massage,
    CategoryType.restaurant,
  ];

  @override
  onInit() {
    // category.value = Get.arguments["category"];
    controller.addListener(listen);
    super.onInit();
  }

  // @override
  // void onReady() {
  //   getListAttribute();
  //   if (isFilterCity.value == true) {
  //     getListDistrictByProvinceID(cityCode.value);
  //   } else {
  //     final MainController mainController = Get.find();
  //     getListDistrictByProvinceID(mainController.currentCityCode.value);
  //   }
  //   super.onReady();
  // }

  handleUpdateCityCode(String code) {
    cityCode.value = code;
    isFilterCity.value = true;
  }

  handleUpdateSelectedDistrict(DistrictData district) {
    selectedDistrics.value = district;

    var getDistricString = "";
    if (district.name != null) {
      districtString.value = district.code ?? "";
      getDistricString = district.code ?? "";
    } else {
      districtString.value = "";
    }
    handleFilterVendor(
        attributeString.value,
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        cityCode.value,
        getDistricString,
        varientString.value);
  }

  handleUpdateDefaultCategory(CategoryType category) {
    selectedCategory.value = [category];
    categoriesString.value = category.getType();
  }

  handleUpdateListSelectedCategory(List<CategoryType> categories) {
    selectedCategory.value = categories;
    var categoriesListString = "";
    for (var element in categories) {
      if (categoriesListString == "") {
        categoriesListString = element.getType();
      } else {
        categoriesListString = categoriesString + "," + element.getType();
      }
    }
    categoriesString.value = categoriesListString;
    handleFilterVendor(
        attributeString.value,
        minPrice.value,
        maxPrice.value,
        categoriesListString,
        cityCode.value,
        districtString.value,
        varientString.value);
  }

  handleUpdateSelectedProvince(ProvinceData data) {
    selectedProvince.value = data;
    var getProvinceString = "";
    if (data.name != null) {
      provinceString.value = data.code ?? "";
      getProvinceString = data.code ?? "";
    } else {
      provinceString.value = "";
    }
    handleFilterVendor(
        attributeString.value,
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        getProvinceString,
        districtString.value,
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
        minPrice.value,
        maxPrice.value,
        categoriesString.value,
        provinceString.value,
        districtString.value,
        varientString.value);
  }

  handleUpdateSelectedPriceRange(PriceRangeModel priceRange) {
    selectedPriceRange.value = priceRange;
    if (priceRange.title == "") {
      minPrice.value = "0";
      maxPrice.value = "0";
    } else {
      minPrice.value = priceRange.min;
      maxPrice.value = priceRange.max;
    }

    handleFilterVendor(
        attributeString.value,
        priceRange.min,
        priceRange.max,
        categoriesString.value,
        provinceString.value,
        districtString.value,
        varientString.value);
  }

  handleGetListVendorByCategory(String cityCode, VariantModel? varient) {
    final MainController mainController = Get.find();
    final latitude = mainController.latitude.value;
    final longitude = mainController.longitude.value;
    lat.value = latitude;
    lng.value = longitude;
    if (varient != null) {
      selectedVariant.value = varient;
      if (varient.name != "") {
        varientString.value = varient.id;
      } else {
        varientString.value = "";
      }
    }

    getFilterVendor(
        cityCode, longitude, latitude, varient == null ? "" : varient.id);
  }

  handleUpdateSelectedVariant(VariantModel data) {
    selectedVariant.value = data;
    if (data.name != "") {
      varientString.value = data.id;
    } else {
      varientString.value = "";
    }

    handleFilterVendor(attributeString.value, minPrice.value, maxPrice.value,
        categoriesString.value, cityCode.value, districtString.value, data.id);
  }

  getListAttribute() async {
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

  Future<void> getListSubCategory(CategoryType? category) async {
    if (category == null)
      return;
    else {
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
  }

  getListVenderByCategory(String type) async {
    try {
      isLoading(true);
      var response = await _apiClient.getSearchVendors("", "", "", "", "");
      if (response.status == 200) {
        listVendors.value = response.data!.docs!;
        if (response.data!.docs!.isEmpty) {
          isEmptyResult(true);
        } else {
          isEmptyResult(false);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleFilterVendor(
      String attributes,
      String minPrice,
      String maxPrice,
      String categories,
      String cityCode,
      String distric,
      String subCategory) async {
    try {
      isLoading(true);
      var response = await _apiClient.getFilterVendor(
          attributes,
          "",
          lng.value,
          lat.value,
          limit.value,
          1,
          minPrice,
          maxPrice,
          categories,
          cityCode,
          distric,
          "",
          subCategory);
      if (response.status == 200) {
        listVendors.value = response.data.docs!;
        totalDocs.value = response.data.totalDocs ?? 0;
        page.value = 1;
        if (response.data.docs!.isEmpty) {
          isEmptyResult(true);
        } else {
          isEmptyResult(false);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  getFilterVendor(
      String cityCode, String lng, String lat, String varientId) async {
    try {
      isLoading(true);
      var response = await _apiClient.getFilterVendor(
          attributeString.value,
          "",
          lng,
          lat,
          limit.value,
          page.value,
          minPrice.value,
          maxPrice.value,
          categoriesString.value,
          cityCode,
          districtString.value,
          "",
          varientId);
      if (response.status == 200) {
        listVendors.value = response.data.docs!;
        totalDocs.value = response.data.totalDocs ?? 0;

        if (response.data.docs!.isEmpty) {
          isEmptyResult(true);
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
    try {
      var response = await _apiClient.getFilterVendor(
          attributeString.value,
          "",
          lng.value,
          lat.value,
          limit.value,
          newPage,
          minPrice.value,
          maxPrice.value,
          categoriesString.value,
          cityCode.value,
          districtString.value,
          "",
          varientString.value);
      if (response.status == 200) {
        final data = response.data.docs ?? [];
        listVendors.value = [...listVendors, ...data];
        if (response.data.docs!.isEmpty) {
          isEmptyResult(true);
        } else {
          isEmptyResult(false);
        }
      }
    } on Exception catch (err) {
      log("err $err");
    }
  }

  listen() {
    final direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }

    if (controller.offset == controller.position.maxScrollExtent) {
      if (listVendors.length < totalDocs.value) {
        handleGetMoreVendors();
      }
    }
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
}
