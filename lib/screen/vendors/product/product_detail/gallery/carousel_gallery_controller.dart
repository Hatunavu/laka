import 'package:get/get.dart';

class VendorCarouselGalerryController extends GetxController {
  final String title = "carousel gallery";
  final startPoint = 0.0.obs;
  final backgroundOpacity = 1.0.obs;
  final imageWidth = 0.0.obs;

  updateStartPoint(double point) {
    startPoint.value = point;
  }

  // createWithImage(double width) {
  //   imageWidth.value = width;
  // }

  // updateBackgroundOpacity(double point) {
  //   if (backgroundOpacity.value >= 0 && backgroundOpacity.value <= 1) {
  //     backgroundOpacity.value = backgroundOpacity.value - (point / 500);
  //   }
  //   imageWidth.value = imageWidth.value - point * 0.3;
  // }

}
