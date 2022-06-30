import 'package:get/get.dart';

class FilterChipItemController extends GetxController {
  var isSelect = false.obs;
  select() => isSelect.value = !isSelect.value;
}
