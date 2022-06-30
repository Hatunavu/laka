import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/app_path.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/search/debounce.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';
import 'package:client_tggt/screen/activity/maps_derection/direction_model.dart';
import 'package:client_tggt/screen/activity/maps_derection/direction_repository.dart';
import 'package:client_tggt/screen/filter_vendors/widget/google_map.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/custome_cupertino_alert.dart';
import 'package:client_tggt/shared/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as per;
// import 'package:permission_handler/permission_handler.dart';

class MapsDerectionScreen extends StatefulWidget {
  MapsDerectionScreen({Key? key, required this.vendorInfo}) : super(key: key);
  final VendorModel vendorInfo;
  @override
  State<MapsDerectionScreen> createState() => _MapsDerectionScreenState();
}

class _MapsDerectionScreenState extends State<MapsDerectionScreen> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  late String latitude;
  late String longtitude;
  late double vendorLat;
  late double vendorLng;
  CameraPosition? _initialCameraPosition;
  late GoogleMapController _googleMapController;

  BitmapDescriptor? markerbitmap;
  Directions? _info;
  bool isStartDirrection = false;
  bool isDispose = false;
  bool isEnableService = false;
  bool isLoading = false;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    location.changeSettings(interval: 300, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    checkPermission();

    final MainController mainController = Get.find();
    setState(() {
      latitude = mainController.latitude.value;
      longtitude = mainController.longitude.value;
      if (widget.vendorInfo.address.location.coordinates == null) {
        print("đã có lỗi xảy ra, không tìm thấy địa chỉ của cơ sở này");
      } else {
        setState(() {
          vendorLat = widget.vendorInfo.address.location.coordinates![1];
          vendorLng = widget.vendorInfo.address.location.coordinates![0];
          _initialCameraPosition = CameraPosition(
              target: LatLng(vendorLat, vendorLng), zoom: 13.5, tilt: 30);
        });
      }
    });
    handleAddIconMarker();

    super.initState();
  }

  checkPermission() async {
    Location location = Location();

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
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return CustomCupertinoAlert(
              context: context,
              title: "Thông báo",
              content:
                  'Bạn cần cấp quyền cho App Laka truy cập vào vị trí để thực hiện chỉ đường',
              rightButtonTitle: 'Cài đặt',
              leftButtonTitle: 'confirm'.tr,
              leftAction: () async {
                Navigator.pop(context);
              },
              rightAction: () async {
                Navigator.pop(context);
                context.router.pop();
                per.openAppSettings();
              },
            );
          });
      setState(() {
        isEnableService = false;
      });
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    setState(() {
      isEnableService = true;
    });
    addPolyDirection();
  }

  Future<void> addPolyDirection() async {
    final MainController mainController = Get.find();
    final directions = await DirectionsRepository().getDirections(
        origin: LatLng(double.parse(mainController.latitude.value),
            double.parse(mainController.longitude.value)),
        destination: LatLng(widget.vendorInfo.address.location.coordinates![1],
            widget.vendorInfo.address.location.coordinates![0]));
    if (directions != null) {
      if (directions.bounds != null) {
        setState(() => _info = directions);
      } else {
        print("đã có lỗi xảy ra");
      }
    } else {
      print("đã có lỗi xảy ra");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Chỉ đường",
        leading: IconButton(
            onPressed: () {
              _locationSubscription?.cancel();
              _googleMapController.dispose();
              context.router.pop();
            },
            icon: Icon(
              Ionicons.chevron_back_outline,
              size: 21.sp,
              color:
                  ThemeServices().isDarkMode ? kColorPrimaryDark : Colors.black,
            )),
        child: isLoading == true
            ? const LoadingScreen()
            : Stack(
                children: [
                  renderMapView(context),
                  Positioned(
                      top: 30.h,
                      left: MediaQuery.of(context).size.width / 2 - 30.w,
                      child: _info != null
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.w, horizontal: 26.w),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).backgroundColor,
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Text(
                                _info!.totalDistance.toString(),
                                style: titleStyle.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          : Container()),
                  Positioned(
                      bottom: 20.h,
                      left: MediaQuery.of(context).size.width / 2 - 50.w,
                      child: isEnableService == true
                          ? InkWell(
                              onTap: () {
                                if (isStartDirrection == false) {
                                  _listenLocation();

                                  setState(() {
                                    isStartDirrection = true;
                                    _googleMapController.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(
                                                    double.parse(latitude),
                                                    double.parse(longtitude)),
                                                zoom: 16,
                                                tilt: 40)));
                                  });
                                } else {
                                  _stopListening();
                                  setState(() {
                                    isStartDirrection = false;
                                    _googleMapController.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                                target: LatLng(vendorLat,
                                                    vendorLng), //Hà Nội
                                                zoom: 13.5,
                                                tilt: 30)));
                                  });
                                }
                              },
                              child: isStartDirrection == false
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.w, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.navigate_outline,
                                            size: 18.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4.h),
                                            child: Text(
                                              "Chỉ đường",
                                              style: titleStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.w, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.navigate_outline,
                                            size: 18.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4.h),
                                            child: Text(
                                              "Dừng chỉ đường",
                                              style: titleStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                            )
                          : Container())
                ],
              ));
  }

  void dispose() {
    _locationSubscription?.cancel();
    _googleMapController.dispose();

    super.dispose();
  }

  handleAddIconMarker() async {
    final locationIcon = ThemeServices().isDarkMode
        ? AppPath.locationIconDark
        : AppPath.locationIconLight;
    BitmapDescriptor _markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(30.w, 30.h)),
      locationIcon,
    );
    setState(() {
      markerbitmap = _markerbitmap;
      isLoading = false;
    });
  }

  renderMapView(BuildContext context) {
    String _mapStyle = '';
    rootBundle
        .loadString(ThemeServices().isDarkMode
            ? 'assets/map_style_dark.txt'
            : 'assets/map_style.txt')
        .then((string) {
      _mapStyle = string;
    });

    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition == null
          ? CameraPosition(
              target: LatLng(widget.vendorInfo.address.location.coordinates![1],
                  widget.vendorInfo.address.location.coordinates![0]), //Hà Nội
              zoom: 13.5,
              tilt: 30)
          : _initialCameraPosition!,
      onMapCreated: (controller) {
        controller.setMapStyle(_mapStyle);
        _googleMapController = controller;
      },
      polylines: {
        if (_info != null)
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.grey,
            width: 8,
            points: _info!.polylinePoints!
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
      },
      markers: {
        Marker(
            markerId: MarkerId(widget.vendorInfo.id ?? ""),
            infoWindow: InfoWindow(title: widget.vendorInfo.brandName),
            icon: markerbitmap == null
                ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue)
                : markerbitmap!,
            position: LatLng(widget.vendorInfo.address.location.coordinates![1],
                widget.vendorInfo.address.location.coordinates![0]))
      },
    );
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      setState(() {
        longtitude = currentlocation.longitude.toString();
        latitude = currentlocation.latitude.toString();
      });
      final directions = await DirectionsRepository().getDirections(
          origin: LatLng(currentlocation.latitude ?? double.parse(latitude),
              currentlocation.longitude ?? double.parse(longtitude)),
          destination: LatLng(
              widget.vendorInfo.address.location.coordinates![1],
              widget.vendorInfo.address.location.coordinates![0]));
      if (directions != null) {
        if (directions.bounds != null) {
          if (isDispose == false) {
            if (mounted) {
              setState(() => _info = directions);
            }
          }
        } else {
          print("đã có lỗi xảy ra");
        }
      } else {
        print("đã có lỗi xảy ra");
      }
    });
  }

  _stopListening() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
