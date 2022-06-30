import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/model/vendor/attribute_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ServiceAttributes extends StatelessWidget {
  const ServiceAttributes({
    Key? key,
    required this.listAtributes,
  }) : super(key: key);

  final List<AttributeModel> listAtributes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.h,
      width: 200.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...listAtributes.map(
            (e) => CachedNetworkImage(
              imageUrl: e.image ?? '',
              memCacheHeight: 200,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.grey.withOpacity(0.2),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
