import 'dart:developer';

import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

class VendorProfileAddressScreen extends StatefulWidget {
  VendorProfileAddressScreen({Key? key, this.onBack}) : super(key: key);

  final kInitialPosition = LatLng(21.030495, 105.852392);
  final Function(
    double lat,
    double lng,
    bool isError,
  )? onBack;
  @override
  _VendorProfileAddressScreenState createState() =>
      _VendorProfileAddressScreenState();
}

class _VendorProfileAddressScreenState
    extends State<VendorProfileAddressScreen> {
  // final PickResult selectedPlace = PickResult();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      //     body: PlacePicker(
      //   apiKey: "AIzaSyBJB-_VFmbXNY9oC5D9YuMGI2axPz8ReQ8",
      //   hintText: "Tìm địa điểm ...",
      //   searchingText: "Đang tải ...",
      //   selectText: "Chọn địa điểm",
      //   outsideOfPickAreaText: "Địa chỉ không tồn tại",
      //   initialPosition: widget.kInitialPosition,
      //   useCurrentLocation: true,
      //   selectInitialPosition: true,
      //   usePinPointingSearch: true,
      //   usePlaceDetailSearch: true,
      //   onPlacePicked: (result) async {
      //     inspect(result);
      //     final geometry = result.geometry;
      //     final double lat;
      //     final double lng;
      //     if (geometry == null) {
      //       lat = 21.030495;
      //       lng = 105.852392;
      //       await widget.onBack?.call(lat, lng, true);
      //     } else {
      //       lat = geometry.location.lat;
      //       lng = geometry.location.lng;
      //       await widget.onBack?.call(lat, lng, false);
      //     }
      //     await context.router.pop();
      //   },
      // )
      title: "Cập nhật địa chỉ",
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Ionicons.chevron_back_outline,
            size: 23,
            color: Colors.black,
          )),
      child: Container(
        alignment: Alignment.center,
        child: Text("Tính năng đang được phát triển", style: titleStyle),
      ),
    );
  }
}
