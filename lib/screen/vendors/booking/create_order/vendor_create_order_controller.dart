import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/model/vendor_page/booking/update_booking_request.dart';
import 'package:client_tggt/model/voucher/voucher_model.dart';
import 'package:client_tggt/screen/vendors/main/vendors_main_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class VendorCreateOrderController extends GetxController {
  final String title = "vendor_create_order";
  final isLoading = false.obs;

  final RxList<ServicesModel> listServices = RxList<ServicesModel>();
  final listVoucher = <VoucherModel>[].obs;
  final ApiClient _apiClient;
  ScrollController listServiceController = ScrollController();
  final isLoadingPick = false.obs;
  final page = 1.obs;
  final limit = 10.obs;
  final totalDocs = 0.obs;
  final status = "".obs;
  final selectedServices = ServicesModel(
    active: true,
    attributes: [],
    details: '',
    name: '',
    price: 0,
  ).obs;
  final priceController = TextEditingController(text: "").obs;
  final discountController = TextEditingController(text: "").obs;
  final finalPrice = "0".obs;
  final finalPriceString = "0".obs;
  final listError = [].obs;
  final orderPrice = "0".obs;

  final listLocalImages = <GalleryModel>[].obs;
  final listUrlImageUpload = <String>[].obs;

  final _picker = ImagePicker();
  VendorCreateOrderController(this._apiClient);
  final VendorMainController vendorMainController =
      Get.put(VendorMainController(getIt.get<ApiClient>()));
  @override
  void onInit() {
    handleGetListProduct(50, 1, "", "");
    super.onInit();
  }

  Future<void> handleGetListProduct(
      int limit, int page, String active, String status) async {
    try {
      isLoading(true);
      final response =
          await _apiClient.getListServices(limit, page, active, status);
      if (response.status == 200) {
        if (response.data == null) {
          listServices.value = [];
        }
        if (response.data!.docs == null) {
          listServices.value = [];
        } else {
          listServices.value = response.data!.docs!
              .where((element) => element.status == "published")
              .toList();
        }
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoading(false);
    }
  }
  // vendorGetVoucher

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  handleSaveServicesPrice() {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    finalPrice.value = currencyFormatter.format(double.parse(
        priceController.value.text == "" ? "0" : priceController.value.text));
    finalPriceString.value = priceController.value.text;
  }

  handleUpdateDiscount() {
    final currencyFormatter = NumberFormat('#,##0', 'ID');
    final price = double.parse(
        priceController.value.text == "" ? "0" : priceController.value.text);
    final discount = double.parse(discountController.value.text == ""
        ? "0"
        : discountController.value.text);
    final priceAfterDiscount = price - (price / 100 * discount);
    finalPrice.value = currencyFormatter.format(priceAfterDiscount);
    finalPriceString.value = '$priceAfterDiscount';
  }

  handleRemoveImageBill(int index) {
    listLocalImages.removeAt(index);
    listUrlImageUpload.removeAt(index);
  }

  handleUploadImageGallery(ImageSource source) async {
    isLoadingPick(true);
    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    final permissionStatus = await permission.request();
    switch (permissionStatus) {
      case PermissionStatus.denied:

      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:

      case PermissionStatus.granted:
        // Do nothing
        break;
      case PermissionStatus.limited:
        break;
    }
    final image = await _picker.pickImage(source: source);
    if (image == null) {
      isLoadingPick(false);
      return;
    }

    final fileExtension = p.extension(image.path).replaceAll('.', '');
    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      log("định dạng ảnh không được hỗ trợ");
      isLoadingPick(false);
    }

    try {
      final generateImageUrlResponse =
          await _apiClient.generateImageOrderComplete(
        GenerateAwsImageRequest(fileType: fileExtension),
      );
      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));

      if (uploadResult) {
        listUrlImageUpload.add(generateImageUrlResponse.awsImage.downloadUrl);
        final localImageShow = GalleryModel(path: image.path, type: "image");
        listLocalImages.add(localImageShow);
        if (listError.contains("image")) {
          listError.remove("image");
        }
        isLoadingPick(false);
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }

  Future<bool?> handleCreateOrder() async {
    var errors = [];
    if (priceController.value.text == "") {
      errors.add("totalPrice");
    }
    if (listLocalImages.isEmpty) {
      errors.add("image");
    }
    if (selectedServices.value.id == "") {
      errors.add("product");
    }
    if (errors.isEmpty) {
      final totalPrice = priceController.value.text;
      final productId = selectedServices.value.id;
      final discountPercent = discountController.value.text;
      final endPrice = finalPriceString.value;
      final listImage = listUrlImageUpload;

      try {
        isLoading(true);
        final request = VendorCreateOrderRequest(
            totalPrice: double.parse(totalPrice),
            images: listImage,
            productId: productId!,
            discountPercent: double.parse(discountPercent),
            note: "",
            voucherId: "",
            finalPrice: double.parse(endPrice));
        final response = await _apiClient.vendorsCreateBill(request);
        if (response.status == 200) {
          return true;
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    } else {
      print("abc");

      listError.value = errors;
    }
  }
}
