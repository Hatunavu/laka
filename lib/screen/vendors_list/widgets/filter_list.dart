import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/screen/vendors_list/widgets/filter_chip_item/filter_chip_item.dart';
import 'package:flutter/material.dart';

class FilterList extends StatelessWidget {
  const FilterList({
    Key? key,
    required this.isSelectAll,
    required this.filterList,
    required this.selectAll,
  }) : super(key: key);

  final bool isSelectAll;
  final List<FilterChipItem> filterList;
  final VoidCallback selectAll;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: kChipPadding,
      children: [
        FilterChip(
          showCheckmark: false,
          label: Text("Tất cả",
              style: isSelectAll ? chipSelectedStyle : subTitleStyle),
          selected: isSelectAll,
          onSelected: (value) {
            selectAll();
          },
        ),
        ...filterList,
      ],
    );
  }
}
