import 'package:client_tggt/api/api_client/api_client.dart';
import 'package:client_tggt/injection.dart';
import 'package:client_tggt/screen/history/history_controller.dart';
import 'package:get/get.dart';

class HistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(
        () => HistoryController(getIt.get<ApiClient>()));
  }
}
