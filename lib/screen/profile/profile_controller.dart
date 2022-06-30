import 'dart:developer';
import 'dart:io';

import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/aws_image/aws_image.dart';
import 'package:client_tggt/model/aws_image/local_image.dart';
import 'package:client_tggt/model/user/account_model.dart';
import 'package:client_tggt/model/user/update_account_information_request.dart';
import 'package:client_tggt/model/user/update_account_request.dart';
import 'package:client_tggt/services/account_services.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;

class ProfileController extends GetxController {
  final String title = "profile";
  final isNotPermission = false.obs;
  final isLoading = false.obs;
  final isLoadingUpdateInformation = false.obs;
  final isLoadingUpdateImage = false.obs;
  final _picker = ImagePicker();
  final ApiClient _apiClient;
  ProfileController(this._apiClient);
  // final LocalImage localImage = LocalImage(awsImage: )
  List<LocalImage> images = <LocalImage>[].obs;
  final account = AccountModel().obs;
  final avatarAccount = AvatarAccount().obs;

  final username = TextEditingController(text: "").obs;
  final address = TextEditingController(text: "").obs;
  final email = TextEditingController(text: "").obs;
  final biography = TextEditingController(text: "").obs;
  final genderType = GenderType.other.obs;

  @override
  void onInit() {
    final userToken = AccountServices().getUserToken();
    super.onInit();
  }

  getMe() async {
    final userToken = AccountServices().getUserToken();
    if (userToken != "") {
      try {
        isLoading(true);
        var data = await _apiClient.getCustomerInfor();
        if (data.status == 200) {
          final accountData = data.data!.account!;
          // final profile = accountData.profile;
          // final phone = accountData.phone;
          // final type = accountData.type;
          // final authentication = accountData.authentication;
          // final vendor = accountData.vendor;
          final gender = accountData.profile!.gender;
          // final affiliate = accountData.affiliate;
          account.value = accountData;
          // account.value = AccountModel(
          //     profile: profile,
          //     phone: phone,
          //     type: type,
          //     authentication: authentication,
          //     affiliate: affiliate,
          //     vendor: vendor);
          avatarAccount.value = data.data!.account!.profile!.avatar!;
          username.value.text = data.data!.account!.profile!.fullName ?? "";
          email.value.text = data.data!.account!.profile!.email ?? "";
          address.value.text = "";
          genderType.value = gender;
          biography.value.text = data.data!.account!.profile!.biography ?? "";
        } else if (data.status == 401) {
          log("Lấy thông tin thất bại");
        }
      } on Exception catch (err) {
        log("err $err");
      } finally {
        isLoading(false);
      }
    }
  }

  handlePickImage(ImageSource source) async {
    isLoadingUpdateImage(true);
    final permission =
        source == ImageSource.camera ? Permission.camera : Permission.photos;
    final permissionStatus = await permission.request();
    switch (permissionStatus) {
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
      // isNotPermission.value = true;
      // print("123");
      // return;
      case PermissionStatus.granted:
        // Do nothing
        break;
      case PermissionStatus.limited:
        break;
    }
    final image = await _picker.pickImage(source: source);
    if (image == null) {
      isLoadingUpdateImage(false);
      return;
    }

    final fileExtension = p.extension(image.path).replaceAll('.', '');
    if (fileExtension != 'png' &&
        fileExtension != 'jpg' &&
        fileExtension != 'jpeg') {
      getIt.get<IToast>().show(
          title: "định dạng ảnh không được hỗ trợ",
          message: "định dạng ảnh không được hỗ trợ",
          hasDismissButton: false,
          duration: const Duration(milliseconds: 1000));
      isLoading(false);
    }
    try {
      final generateImageUrlResponse = await _apiClient.generateImageUrl(
        GenerateAwsImageRequest(fileType: fileExtension),
      );
      final uploadResult = await _apiClient.uploadImage(
          generateImageUrlResponse.awsImage.uploadUrl!, File(image.path));
      if (uploadResult) {
        final updateAccountRequest = UpdateAccountRequest(
            avatar: generateImageUrlResponse.awsImage.downloadUrl);
        final updateAvatar =
            await _apiClient.updateAvatar(updateAccountRequest);

        if (updateAvatar.status == 200) {
          account.value.profile!.avatar = updateAvatar.data;
          avatarAccount.value = updateAvatar.data!;
          isLoadingUpdateImage(false);
          getIt.get<IToast>().show(
              title: 'updateAvatarSuccess'.tr,
              message: 'updateAvatarSuccess'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
        } else {
          log("update avatar false");
          getIt.get<IToast>().show(
              title: 'updateAvatarFailed'.tr,
              message: 'updateAvatarFailed'.tr,
              hasDismissButton: false,
              duration: const Duration(milliseconds: 1000));
          isLoadingUpdateImage(false);
        }
      }
    } on DioError catch (e) {
      final errorMessage = _apiClient.mapDioErrorToMessage(e);
      log(errorMessage);
    }
  }

  handleUpdateGender(GenderType type) {
    genderType.value = type;
  }

  handleUpdateProfile() async {
    try {
      isLoadingUpdateInformation(true);
      final request = UpdateAccountInformationRequest(
          email: email.value.text,
          fullName: username.value.text,
          gender: genderType.value.getType());
      var data = await _apiClient.updateProfileInformation(request);
      if (data.status == 200) {
        final accountData = data.account!;
        final profile = accountData.profile;
        final phone = accountData.phone;
        final type = accountData.type;
        final authentication = accountData.authentication;
        account.value = AccountModel(
          profile: profile,
          phone: phone,
          type: type,
          authentication: authentication,
        );
        getIt.get<IToast>().show(
            title: 'updateInfoSuccessful'.tr,
            message: 'updateInfoSuccessful'.tr,
            hasDismissButton: false,
            duration: const Duration(milliseconds: 1000));
      } else {
        getIt.get<IToast>().show(
            title: 'updateInfoFailed'.tr,
            message: 'updateInfoFailed'.tr,
            hasDismissButton: false,
            duration: const Duration(milliseconds: 1000));
      }
    } on Exception catch (err) {
      log("err $err");
    } finally {
      isLoadingUpdateInformation(false);
    }
  }
}
