import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/activity/activity_controller.dart';
import 'package:client_tggt/screen/bookmark/bookmark_controller.dart';
import 'package:client_tggt/screen/home/home_controller.dart';
import 'package:client_tggt/screen/main/main_controller.dart';
import 'package:client_tggt/screen/message/newfeed_controller.dart';
import 'package:client_tggt/screen/notification/notification_controller.dart';
import 'package:client_tggt/screen/profile/profile_controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(getIt.get<ApiClient>()));
    Get.lazyPut<HomeController>(() => HomeController(getIt.get<ApiClient>()));

    Get.lazyPut<BookmarkController>(() => BookmarkController());
    Get.lazyPut<NewfeedController>(
        () => NewfeedController(getIt.get<ApiClient>()));
    Get.lazyPut<NotificationController>(
        () => NotificationController(getIt.get<ApiClient>()));
    Get.lazyPut<ProfileController>(
        () => ProfileController(getIt.get<ApiClient>()));
    // Get.lazyPut<VendorsController>(
    //     () => VendorsController(getIt.get<ApiClient>()));
    Get.lazyPut<ActivityController>(
        () => ActivityController(getIt.get<ApiClient>()));
  }
}
