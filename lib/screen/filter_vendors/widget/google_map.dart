import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class GoogleMapView extends StatelessWidget {
  const GoogleMapView({
    Key? key,
    required this.onMapCreate,
    required this.listMarker,
  }) : super(key: key);
  final Set<Marker> listMarker;
  final Function(GoogleMapController mapController) onMapCreate;
  @override
  Widget build(BuildContext context) {
    String _mapStyle = '';
    rootBundle
        .loadString(ThemeServices().isDarkMode
            ? 'assets/map_style_dark.txt'
            : 'assets/map_style.txt')
        .then((string) {
      _mapStyle = string;
    });
    return Container(
      padding: EdgeInsets.zero,
      child: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.00198007320593, 105.84499934842783), //Hà Nội
          zoom: 12,
        ),
        onMapCreated: (controller) {
          controller.setMapStyle(_mapStyle);
          onMapCreate(controller);
        },
        markers: listMarker,
      ),
    );
  }
}
