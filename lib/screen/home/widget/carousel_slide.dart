import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/model/banner/banner_model.dart';
import 'package:client_tggt/model/category/enum_category.dart';
import 'package:client_tggt/model/category/home_splash_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_route/auto_route.dart';

class CarouselSlide extends StatefulWidget {
  CarouselSlide({Key? key, required this.listSplashImage}) : super(key: key);
  final List<BannerModel> listSplashImage;
  @override
  State<CarouselSlide> createState() => _CarouselSlideState();
}

class _CarouselSlideState extends State<CarouselSlide> {
  var carouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                // height: 120.h,
                aspectRatio: 2 / 1,
                viewportFraction: 0.95,
                initialPage: 0,
                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                reverse: false,
                autoPlay: true,
                //autoPlayCurve: Curves.easeInOutCubicEmphasized,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(seconds: 2),
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, resson) {
                  // homeController.handleUpdateCarouselIndex(index);
                  setState(() {
                    carouselIndex = index;
                  });
                },
                enlargeStrategy: CenterPageEnlargeStrategy.height),
            items: widget.listSplashImage.map((item) {
              return GestureDetector(
                onTap: () {
                  context.router.push(
                    VendorsDetailPage(
                        first: item.vendor!.id ?? "",
                        last: item.vendor!.category.getType(),
                        tagId: "home-banner-${item.vendor!.id}",
                        imageUrl: item.vendor!.thumbnail?.path ?? "",
                        vendorTitle: item.vendor!.brandName,
                        vendorsInfo: item.vendor!,
                        voucher: null),
                  );
                },
                child: Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width + 5,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(item
                                  .image), //CachedNetworkImageProvider(item.image),
                              fit: BoxFit.fill)),
                    );
                  },
                ),
              );
            }).toList(),
          ),
          Positioned(
            bottom: 8,
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: 3.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.listSplashImage.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    width: kDefaultPaddingWidget.w,
                    color:
                        carouselIndex == index ? Colors.grey[50] : Colors.grey,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
