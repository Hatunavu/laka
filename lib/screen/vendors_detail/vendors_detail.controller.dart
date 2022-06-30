import 'dart:developer';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/newfeed/post/post.dart';
import 'package:client_tggt/model/newfeed/reaction/update_reaction_request.dart';
import 'package:client_tggt/model/order/staff/staff_model.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/model/voucher/enum_voucher.dart';
import 'package:client_tggt/model/voucher/enum_voucher_status.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/utils/tggt_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:story_view/story_view.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorsDetailController extends GetxController {
  final storyController = StoryController();
  late GoogleMapController mapController;
  var listMarker = <Marker>{}.obs;
  var listSuggestedServices = <VendorModel>[].obs;
  var scrollController = ScrollController().obs;
  var isPinned = false.obs;
  var currentVendor = VendorModel(
    address: VendorAddressModel(fullAddress: "", location: VendorLocaltion()),
    brandName: '',
    category: CategoryType.bar,
  ).obs;
  var serviceName = "Phòng Vip".obs;
  var price = "".obs;
  var serviceDetail = "".obs;
  final isLoading = false.obs;
  final ApiClient _apiClient;
  var currentIndex = 1.obs;
  final dataKey = GlobalKey();
  final isFetchAllData = false.obs;

  final listPosts = <PostModel>[].obs;
  final listStaff = <StaffModel>[].obs;
  final listVoucher = <VoucherModel>[].obs;

  final tabIndex = 0.obs;

  VendorsDetailController(this._apiClient);
  var isOnTop = true.obs;
  var isScroll = false.obs;

  final selectedVoucher = VoucherModel(
          id: "",
          discount: DiscountVoucherModel(type: "system", amount: 0),
          title: "",
          active: false,
          code: "",
          status: VoucherStatusType.expireDate,
          type: VoucherType.system)
      .obs;
  final isSelectedVoucher = false.obs;
  @override
  onInit() {
    super.onInit();
    final arguments = Get.arguments;
    final id = arguments != null ? arguments.first : "";
    final category = arguments != null ? arguments.last : "";
    setID(id, category);
    scrollController.value.addListener(() {
      // if (scrollController.value.offset == 0) {
      //   isScroll.value = false;
      // }
      if (!isPinned.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset > 150.h) {
        isPinned.value = true;
      } else if (isPinned.value &&
          scrollController.value.hasClients &&
          scrollController.value.offset < 150.h) {
        isPinned.value = false;
      }
    });
  }

  launchMaps() async {
    String address =
        Uri.encodeComponent(currentVendor.value.address.fullAddress);
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$address";
    String googleAppUrl =
        'comgooglemaps://?daddr=$address&directionsmode=driving';
    if (await canLaunch("comgooglemaps://")) {
      debugPrint('launching com googleAppUrl');
      await launch(googleAppUrl);
    } else if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    }
  }

  addMarker(BuildContext context) async {
    // ignore: invalid_use_of_protected_member
    listMarker.value = {};
    final lng = currentVendor.value.address.location.coordinates?.first ?? 0;
    final lat = currentVendor.value.address.location.coordinates?.last ?? 0;
    final latLng = LatLng(lat, lng);
    var markerIdVal = currentVendor.value.id;
    final MarkerId markerId = MarkerId(markerIdVal ?? '');
    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(
          title: currentVendor.value.brandName,
          snippet:
              '${'address'.tr}: ${currentVendor.value.address.fullAddress}'),
    );
    listMarker.add(marker);
  }

  changeCurrentLocationCamera() {
    HomeController homeController = Get.find();
    final currentLocation = homeController.currentLocation;
    mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation.value, zoom: 12)));
  }

  handleChangeStatusScroll() {
    isScroll.value = true;
  }

  setID(String id, String category) {
    if (id.isNotEmpty) {
      _getVendorsDetail(id);
      _getListVendors(category, id);
      isFetchAllData.value = false;
      Future.wait([
        handleGetNewsFeed(id),
        handleGetListStaff(id),
        handleGetListVoucher(id)
      ]).then((value) => {isFetchAllData.value = true});
    }
  }

  reloadSetId(String id, String category) {
    if (id.isNotEmpty) {
      _getVendorsDetail(id);
      isFetchAllData.value = false;
      Future.wait([
        handleGetNewsFeed(id),
        handleGetListStaff(id),
        handleGetListVoucher(id)
      ]).then((value) => {isFetchAllData.value = true});
    }
  }

  Future<void> handleGetNewsFeed(String vendorId) async {
    try {
      final response = await _apiClient.getListPost(15, 1, vendorId);
      if (response.status == 200) {
        final data = response.data.docs;
        listPosts.value = data ?? [];
      }
    } on Exception catch (err) {
      log("err $err");
    }
  }

  handleUpdatePostReaction(String postId, String type) async {
    try {
      final request = UpdateReactionRequest(type: type);
      final response = await _apiClient.updateReaction(postId, request);
      if (response.status == 200) {
        int index = listPosts.indexWhere((element) => element.id == postId);
        listPosts[index].reacted = response.data.reacted;
        listPosts[index].totalReactions = response.data.totalReactions;
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }

  Future<void> handleGetListStaff(String vendorId) async {
    final userToken = AccountServices().getUserToken();
    if (userToken != "") {
      try {
        final response = await _apiClient.customerGetListStaff(vendorId);
        if (response.status == 200) {
          final data = response.data.docs;
          listStaff.value = data ?? [];
        }
      } on Exception catch (err) {
        log("err $err");
      }
    } else {
      return;
    }
  }

  updateSimilarVendor(VendorModel selectedVendor, VendorModel preVendor) {
    var newList = listSuggestedServices
        .where((element) => element != selectedVendor)
        .toList();
    newList = [preVendor, ...newList];
    inspect(newList);

    listSuggestedServices.value = newList;
  }

  Future<void> handleGetListVoucher(String vendorId) async {
    try {
      isLoading(true);
      var response = await _apiClient.getListVoucher(30, 1, "", vendorId);
      if (response.status == 200) {
        final data = response.data;
        if (data != null) {
          listVoucher.value = data.docs == null
              ? []
              : data.docs!
                  .where((element) =>
                      element.status != VoucherStatusType.expireDate)
                  .toList();
        }
      }
    } on Exception catch (err) {
    } finally {
      isLoading(false);
    }
  }

  setVoucher(VoucherModel voucher) {
    selectedVoucher.value = voucher;
    isSelectedVoucher.value = true;
  }

  scrollToTop() {
    scrollController.value.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  setProduct(String service, double price, String? detail) {
    serviceName.value = service;
    this.price.value = TGGTUtils().formatMoney(price);
    serviceDetail.value = detail ?? "";
  }

  String formatDate(String date) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = dateFormat.parse(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  _getVendorsDetail(String id) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(milliseconds: 800));
      var response = await _apiClient.getVendorDetail(id);
      if (response.status == 200) {
        //log("getListVendors: ${data.data.hotVendors.toString()}");
        if (response.vendorItem != null) {
          currentVendor.value = response.vendorItem!;
          if (currentVendor.value.products != null) {
            setProduct(
                currentVendor.value.products?.first.name ?? '',
                currentVendor.value.products?.first.price ?? 0,
                currentVendor.value.products?.first.details ?? '');
          }
          if (scrollController.value.hasClients) {
            scrollToTop();
          }
        }
      } else {}
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }

  _getListVendors(String category, String vendorId) async {
    try {
      var response = await _apiClient.getListVendors(category);
      if (response.status == 200) {
        final data = response.data.suggestedVendors
            .where((element) => element.id != vendorId)
            .toList();
        listSuggestedServices.value = data;
      } else {}
    } on Exception catch (err) {
      log("err $err");
    } finally {}
  }
}
