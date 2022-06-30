import 'package:client_tggt/screen/vendors_gallery/vendors_gallery_controller.dart';
import 'package:get/get.dart';

class VendorsGalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorsGalleryController>(() => VendorsGalleryController());
  }
}
