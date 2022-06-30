import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/auth/create_vendor/location/district_response/district_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/province_response/province_data.dart';
import 'package:client_tggt/model/auth/create_vendor/location/ward_response/ward_data.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/screen/auth/signin/signin_screen.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignupVendorScreen extends StatelessWidget {
  const SignupVendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignupVendorController controller =
        Get.put(SignupVendorController(getIt.get<ApiClient>()));
    controller.getListProvinces();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          slivers: [
            buildHeader(context, controller),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(kDefaultPaddingWidget.h),
                child: Column(
                  children: [
                    buildForm(controller.formKey, controller, context),
                    SizedBox(height: kDefaultPaddingWidget.h * 2),
                    InkWellButton(
                        label: 'confirm'.tr,
                        onPressed: () {
                          controller.formKey.currentState!.save();
                          if (controller.formKey.currentState!.validate()) {
                            controller.handleSignUpVendor();
                          }
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FormBuilder buildForm(GlobalKey<FormBuilderState> _formKey,
      SignupVendorController controller, BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          controller.errorMessage.value != ""
              ? showErrorText(context, controller.errorMessage.value)
              : Container(),
          FormBuilderTextField(
            name: 'phoneNumber'.tr,
            keyboardType: TextInputType.phone,
            controller: controller.phoneTextController.value,
            decoration: InputDecoration(
              labelText: 'phoneNumber'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'notEnterPhoneNumber'.tr;
              } else if (value.split("").length != 10 ||
                  value.split("")[0] != "0") {
                return "incorrectPhone".tr;
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'password'.tr,
            obscureText: true,
            controller: controller.passwordTextController.value,
            decoration: InputDecoration(
              labelText: 'password'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'notEnterPassword'.tr;
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'confirmPassword'.tr,
            obscureText: true,
            controller: controller.confirmpasswordTextController.value,
            decoration: InputDecoration(
              labelText: 'confirmPassword'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'notEnterConfirmPassword'.tr;
              } else if (value !=
                  controller.passwordTextController.value.text) {
                return 'confirmPasswordNotMatch';
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'brandName'.tr,
            controller: controller.brandNameTextController.value,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'brandName'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'notEnterBrandName'.tr;
              }
              return null;
            },
          ),
          FormBuilderTextField(
            name: 'detail'.tr,
            controller: controller.detailTextController.value,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: 'detail'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'notEnterDetail'.tr;
              }
              return null;
            },
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: DropdownSearch<CategoryType>(
              mode: Mode.BOTTOM_SHEET,
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                suffixIcon: Text('category'.tr),
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
              ),
              dropDownButton: const SizedBox(),
              selectedItem: CategoryType.karaoke,
              onChanged: (value) {
                if (value != null) {
                  controller.categoryType.value = value;
                }
              },
              itemAsString: (item) => item?.display() ?? '',
              items: const [
                ...CategoryType.values,
              ],
            ),
          ),
          // const SizedBox(
          //   height: kDefaultPaddingWidget * 2,
          // ),
          Obx(
            () => Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownSearch<ProvinceData>(
                mode: Mode.BOTTOM_SHEET,
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  suffixIcon: Text('province'.tr),
                  suffixIconConstraints:
                      const BoxConstraints(minWidth: 0, minHeight: 0),
                ),
                selectedItem: null,
                dropDownButton: const SizedBox(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedProvince.value = value;
                    controller.getListDistricts(value.code ?? '');
                  }
                },
                itemAsString: (item) => item?.name ?? '',
                items: [
                  ...controller.listProvinces.map((element) => element),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'notEnterProvince'.tr;
                  }
                  return null;
                },
              ),
            ),
          ),
          // const SizedBox(
          //   height: kDefaultPaddingWidget * 2,
          // ),
          Obx(
            () => Visibility(
              visible: controller.isShowDistrict.value,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownSearch<DistrictData>(
                  enabled: controller.listDistricts.isNotEmpty,
                  mode: Mode.BOTTOM_SHEET,
                  dropdownSearchDecoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    suffixIcon: Text('district'.tr),
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                  selectedItem: null,
                  dropDownButton: const SizedBox(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedDistrict.value = value;
                      controller.getListWards(value.code ?? '');
                    }
                  },
                  itemAsString: (item) => item?.name ?? '',
                  items: [
                    ...controller.listDistricts.map((element) => element),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'notEnterDistrict'.tr;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.isShowWard.value,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownSearch<WardData>(
                  enabled: controller.listWards.isNotEmpty,
                  mode: Mode.BOTTOM_SHEET,
                  dropdownSearchDecoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    suffixIcon: Text('ward'.tr),
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                  ),
                  selectedItem: null,
                  dropDownButton: const SizedBox(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.selectedWard.value = value;
                    }
                  },
                  itemAsString: (item) => item?.name ?? '',
                  items: [
                    ...controller.listWards.map((element) => element),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'notEnterWard'.tr;
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          FormBuilderTextField(
            name: 'address'.tr,
            autocorrect: false,
            controller: controller.fullAddressTextController.value,
            decoration: InputDecoration(
              labelText: 'address'.tr,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'notEnterAddress'.tr;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  SliverAppBar buildHeader(
      BuildContext context, SignupVendorController controller) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        "createVendor".tr,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Theme.of(context).backgroundColor),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          context.router.pop();
        },
        icon: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(kChipPadding),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ThemeServices().isDarkMode
                      ? Theme.of(context).primaryColor
                      : kColorBackgroundLight,
                  borderRadius: BorderRadius.circular(99)),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: kColorBackgroundDark,
                size: 16,
              ),
            ),
          ),
        ),
      ),
      expandedHeight: 200.0.h,
      flexibleSpace: FlexibleSpaceBar(
        background: GestureDetector(
          onTap: () {
            showCupertinoModalPopup<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext dialogContext) {
                  return CupertinoActionSheet(
                    title: Text('action'.tr),
                    // message: const Text('Message'),
                    actions: <CupertinoActionSheetAction>[
                      CupertinoActionSheetAction(
                        child: Text('camera'.tr),
                        onPressed: () {
                          controller.handlePickImage(ImageSource.camera);
                          context.router.pop();
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: Text('photoLibrary'.tr),
                        onPressed: () {
                          controller.handlePickImage(ImageSource.gallery);
                          context.router.pop();
                        },
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () => context.router.pop(),
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                });
          },
          child: Obx(
            () => SizedBox(
              height: 200.h,
              width: double.infinity,
              child: controller.vendorThumbnail.value == ""
                  ? Center(
                      child: Icon(
                        Icons.add_a_photo,
                        color: Theme.of(context).backgroundColor,
                        size: 60.sp,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: controller.vendorThumbnail.value,
                      memCacheHeight: 200,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
