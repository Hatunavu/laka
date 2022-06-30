import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class VendorProductItem extends StatelessWidget {
  const VendorProductItem({Key? key, required this.item}) : super(key: key);
  final ServicesModel item;
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,##0  đ', 'ID');

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                image: DecorationImage(
                    // image: AssetImage("assets/images/bar/bar3.jpg"),
                    image:
                        CachedNetworkImageProvider(item.thumbnail?.path ?? ""),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: kDefaultPaddingWidget.w,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.zero,
                        width:
                            (MediaQuery.of(context).size.width - 30.w) * 0.78,
                        child: Wrap(children: [
                          Text(
                            item.name ?? "",
                            style: titleStyle,
                          ),
                        ])),
                    SizedBox(
                      height: defaultPaddingItem.h,
                    ),
                    Text(
                      currencyFormatter.format(double.parse('${item.price}')),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
