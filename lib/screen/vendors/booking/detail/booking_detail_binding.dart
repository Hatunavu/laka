import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:get/get.dart';

class BookingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailController>(
        () => BookingDetailController(getIt.get<ApiClient>()));
  }
}
