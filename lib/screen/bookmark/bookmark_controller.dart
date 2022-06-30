import 'package:get/get.dart';

class BookmarkController extends GetxController {
  final String title = "bookmark";
  final isLoading = false.obs;

  changeLoading() {
    isLoading.value = !isLoading.value;
  }
}
