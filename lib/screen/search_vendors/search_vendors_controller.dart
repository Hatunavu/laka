import 'package:get/get.dart';

class SearchVendor extends GetxController {
  final String title = "search_vendor";
  final isLoading = false.obs;

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
