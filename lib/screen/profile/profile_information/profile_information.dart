import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/model/user/update_account_information_request.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:client_tggt/shared/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class ProfileInformation extends StatelessWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller =
        Get.put(ProfileController(getIt.get<ApiClient>()));
    return Scaffold(
      body: SafeArea(
          child: InkWell(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            child: Column(
              children: [
                renderHeader(context, controller),
                renderBody(context, controller)
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Widget renderHeader(BuildContext context, ProfileController controller) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPaddingScreen.w,
            vertical: kDefaultPaddingWidget.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context.router.pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 23,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            Obx(
              () => controller.isLoadingUpdateInformation.isFalse
                  ? InkWell(
                      onTap: () {
                        controller.handleUpdateProfile();
                      },
                      child: Container(
                        padding: EdgeInsets.all(defaultPaddingItem.w),
                        child: Text(
                          "save".tr,
                          style: AppTextStyle().titleBold16,
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingWidget.w),
        margin: EdgeInsets.only(bottom: kDefaultPaddingWidget.h),
        alignment: Alignment.centerLeft,
        child: Text(
          "editPersonalInformation".tr,
          style: AppTextStyle().heading2Semi20,
        ),
      )
    ],
  );
}

Widget renderBody(BuildContext context, ProfileController controller) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultPaddingItem.h),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "fullname".tr,
                style: AppTextStyle().titleBold16,
              ),
              customeTextFormField(
                  context, "username".tr, controller.username.value, controller)
            ],
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h * 1.3),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "phoneNumber".tr,
                style: AppTextStyle().titleBold16,
              ),
              Text(
                controller.account.value.phone ?? "",
                style: AppTextStyle().subtitleRegular14Grey,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultPaddingItem.h),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Email".tr,
                style: AppTextStyle().titleBold16,
              ),
              customeTextFormField(
                  context, "Email", controller.email.value, controller)
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: defaultPaddingItem.h),
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "address".tr,
                style: AppTextStyle().titleBold16,
              ),
              customeTextFormField(
                  context, "address".tr, controller.address.value, controller)
            ],
          ),
        ),
        Obx(() => renderChooseGender(context, controller)),
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(
                text: controller.account.value.affiliate?.link ?? ''));
            getIt.get<IToast>().show(
                title: "codeSaved".tr,
                message: "",
                hasDismissButton: false,
                duration: const Duration(milliseconds: 1000));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: defaultPaddingItem.h * 2),
            decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "referralID".tr,
                  style: AppTextStyle().titleBold16,
                ),
                Flexible(
                  child: Text(
                    controller.account.value.affiliate?.link ?? '',
                    style: AppTextStyle().subtitleRegular14,
                    textDirection: TextDirection.rtl,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h * 1.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "introduceYourSelf".tr,
                style: AppTextStyle().titleBold16,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextFormField(
                  cursorColor: const Color(0xFF9b9b9b),
                  textAlign: TextAlign.left,
                  controller: controller.biography.value,
                  minLines: 3,
                  maxLines: 20,
                  onChanged: (text) {},
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "typeHere".tr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customeTextFormField(BuildContext context, String hintText,
    TextEditingController controller, ProfileController profileController) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(left: kDefaultPaddingWidget.h),
      alignment: Alignment.centerRight,
      child: TextFormField(
        style: AppTextStyle().subtitleRegular14,
        controller: controller,
        cursorColor: Theme.of(context).primaryColor,
        textAlign: TextAlign.right,
        minLines: 1,
        maxLines: 2,
        onChanged: (text) {},
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    ),
  );
}

Widget renderChooseGender(BuildContext context, ProfileController controller) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h * 1.3),
    decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "gender".tr,
          style: AppTextStyle().titleBold16,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPaddingScreen.w),
                    height: 200.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: kDefaultPaddingWidget.h),
                          alignment: Alignment.center,
                          child: Text(
                            "chooseGender".tr,
                            style: AppTextStyle().titleBold16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.handleUpdateGender(GenderType.male);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPaddingWidget.h),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  GenderType.male.display(),
                                  style: AppTextStyle().subtitleRegular14,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.genderType.value ==
                                        GenderType.male,
                                    child: Icon(
                                      Ionicons.checkmark_circle_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.handleUpdateGender(GenderType.female);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: kDefaultPaddingWidget.h),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  GenderType.female.display(),
                                  style: AppTextStyle().subtitleRegular14,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.genderType.value ==
                                        GenderType.female,
                                    child: Icon(
                                      Ionicons.checkmark_circle_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.handleUpdateGender(GenderType.other);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: defaultPaddingItem.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  GenderType.other.display(),
                                  style: AppTextStyle().subtitleRegular14,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.genderType.value ==
                                        GenderType.other,
                                    child: Icon(
                                      Ionicons.checkmark_circle_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text(
            controller.genderType.value.display(),
            style: AppTextStyle().subtitleRegular14,
          ),
        )
      ],
    ),
  );
}
