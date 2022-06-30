import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/screen/vendors_list/widgets/filter_chip_item/filter_chip_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FilterChipItem extends GetWidget<FilterChipItemController> {
  const FilterChipItem({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FilterChip(
        showCheckmark: false,
        label: Text(title,
            style:
                controller.isSelect.value ? chipSelectedStyle : subTitleStyle),
        selected: controller.isSelect.value,
        onSelected: (value) {
          controller.select();
        },
      ),
    );
  }
}
