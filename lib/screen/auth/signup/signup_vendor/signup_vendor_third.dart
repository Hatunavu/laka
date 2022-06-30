import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/auth/signup/signup_vendor/signup_vendor_controller.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class SignupVendorThirdScreen extends StatelessWidget {
  const SignupVendorThirdScreen({Key? key, this.onBack}) : super(key: key);
  final Function(
    double lat,
    double lng,
    String fullAddress,
    bool isError,
  )? onBack;
  @override
  Widget build(BuildContext context) {
    final CreateVendorController controller =
        Get.put(CreateVendorController(getIt.get<ApiClient>()));
    return Scaffold(
      // title: "Địa chỉ",
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: PlacePicker(
              apiKey: "AIzaSyBJB-_VFmbXNY9oC5D9YuMGI2axPz8ReQ8",
              hintText: "search".tr + " ...",
              searchingText: "featureDeveloping".tr,
              selectText: "confirmAddress".tr,
              onGeocodingSearchFailed: (text) {
                print(text);
              },
              onAutoCompleteFailed: (text) {
                print(text);
              },
              outsideOfPickAreaText: "addressNotExist".tr,
              initialPosition: const LatLng(21.030495, 105.852392),
              useCurrentLocation: true,
              // selectInitialPosition: true,
              // usePinPointingSearch: true,
              // usePlaceDetailSearch: true,
              onPlacePicked: (result) async {
                final fullAddress = result.formattedAddress;

                final geometry = result.geometry;
                final double lat;
                final double lng;
                if (geometry == null || fullAddress == null) {
                  lat = 21.030495;
                  lng = 105.852392;
                  await onBack?.call(lat, lng, fullAddress ?? "", true);
                } else {
                  lat = geometry.location.lat;
                  lng = geometry.location.lng;
                  await onBack?.call(lat, lng, fullAddress, false);
                }
                await context.router.pop();
              },
            )),
          ],
        ),
      ),
    );
  }
}

Widget renderBottomAction(
    BuildContext context, CreateVendorController controller) {
  return Container(
    padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingScreen.w, vertical: kDefaultPaddingWidget.h),
    decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5.h))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(children: [
          GestureDetector(
            onTap: () {
              context.router.pop();
            },
            child: Text(
              "back".tr,
              style: titleStyle,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            color: Colors.black,
          )
        ]),
        Visibility(
            visible: controller.isCompleteInformation.value == true,
            child: InkwellButtonLoading(label: "next".tr, onPressed: () {}))
      ],
    ),
  );
}
