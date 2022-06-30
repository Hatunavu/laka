import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:get/get.dart';

class ActivityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityController>(
        () => ActivityController(getIt.get<ApiClient>()));
  }
}
