import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/search/debounce.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTagsController extends GetxController {
  final String title = "AddTags";
  final isLoading = false.obs;
  final isLoadMore = false.obs;
  AddTagsController(this._apiClient);
  final limit = 30.obs;
  final page = 1.obs;
  final totalDocs = 0.obs;
  final ApiClient _apiClient;
  RxList<VendorModel> listVendors = RxList<VendorModel>();
  RxList<VendorModel> listSelectedVendors = RxList<VendorModel>();
  ScrollController listVendorsController = ScrollController();
  final searchText = TextEditingController(text: "").obs;

  final _debounce = Debounce(milliseconds: 700);

  @override
  onInit() {
    listVendorsController.addListener(listenLoadMoreList);

    super.onInit();
  }

  handleClearSearch() {
    _debounce.dispose();
    searchText.value.text = "";
    handleSearchVendors("");
  }

  handleSearchVendors(String text) {
    _debounce.run(() async {
      try {
        isLoading(true);
        // var response = await _apiClient.getVendorByText(text);
        var response = await _apiClient.getSearchVendors("", "", text, "", "");
        if (response.status == 200) {
          listVendors.value = response.data!.docs!;
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

  listenLoadMoreList() {
    if (listVendorsController.offset ==
        listVendorsController.position.maxScrollExtent) {
      if (listVendors.length < totalDocs.value) {
        if (listVendors.length < totalDocs.value) {
          getMoreVendors();
        }
      }
    }
  }

  getMoreVendors() async {
    try {
      isLoadMore(true);
      var response = await _apiClient.getFilterVendor("", "", "", "",
          limit.value, page.value + 1, "0", "10000000000", "", "", "", "", "");
      if (response.status == 200) {
        final data = response.data.docs;
        listVendors.value = [...listVendors, ...data ?? []];
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      page.value = page.value + 1;
      isLoadMore(false);
    }
  }

  handleFilterVendor(List<VendorModel> vendors) async {
    listSelectedVendors.value = vendors;
    try {
      isLoading(true);
      var response = await _apiClient.getFilterVendor("", "", "", "",
          limit.value, page.value, "0", "10000000000", "", "", "", "", "");
      if (response.status == 200) {
        listVendors.value = response.data.docs!;
        totalDocs.value = response.data.totalDocs ?? 0;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  handleSelectedVendors(VendorModel vendors) {
    final findVendors = listSelectedVendors
        .where(
          (element) => element.id == vendors.id,
        )
        .toList();
    if (findVendors.isEmpty) {
      listSelectedVendors.add(vendors);
    } else {
      final newList =
          listSelectedVendors.where((item) => item.id != vendors.id).toList();
      listSelectedVendors.value = newList;
    }
  }

  handleRemoveVendors(VendorModel vendors) {
    final newList =
        listSelectedVendors.where((item) => item.id != vendors.id).toList();
    listSelectedVendors.value = newList;
  }
}
