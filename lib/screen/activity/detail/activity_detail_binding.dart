import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/activity/detail/activity_detail_controller.dart';
import 'package:get/get.dart';

class ActivityDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityDetailController>(
        () => ActivityDetailController(getIt.get<ApiClient>()));
  }
}
