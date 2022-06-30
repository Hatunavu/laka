import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/vendor/services_model.dart';
import 'package:client_tggt/model/vendor/variant_model.dart';
import 'package:client_tggt/screen/vendors_detail/widgets/service_card.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductsOfVarientScreen extends StatelessWidget {
  const ProductsOfVarientScreen(
      {Key? key, required this.variant, this.onBack, this.isVendors})
      : super(key: key);
  final VariantModel variant;
  final Function(ServicesModel item)? onBack;
  final bool? isVendors;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: variant.name,
      backgroundColor: Theme.of(context).backgroundColor,
      leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            size: 22.sp,
            color:
                ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight,
          )),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
        padding: EdgeInsets.symmetric(horizontal: kDefaultPaddingScreen.w),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: variant.products!.length,
            itemBuilder: (ctx, index) {
              final productItem = variant.products![index];
              return Container(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      ServiceCard(
                        isDisable: false,
                        isVendors: isVendors,
                        callback: () async {
                          await onBack?.call(productItem);
                          context.router.pop();
                        },
                        product: productItem,
                        category: CategoryType.bar,
                      ),
                      SizedBox(height: kDefaultPadding.h),
                    ],
                  ));
            },
          ),
        ),
      ),
    );
  }
}
