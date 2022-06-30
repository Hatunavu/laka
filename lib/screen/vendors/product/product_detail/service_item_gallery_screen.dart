import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceItemGalleryScreen extends StatelessWidget {
  const ServiceItemGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        backgroundColor: Theme.of(context).backgroundColor,
        title: "Hình ảnh",
        leading: IconButton(
            onPressed: () {
              context.router.pop();
            },
            icon: const Icon(
              Ionicons.chevron_back_outline,
              size: 23,
              color: Colors.black,
            )),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPaddingWidget.w,
              vertical: kDefaultPaddingWidget.h),
          child: Column(children: [
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Ảnh đại diện: ".toUpperCase(),
                        style: TextStyle(
                          fontSize: 13,
                          color: HexColor(greyTextColor),
                        ),
                      ),
                      Icon(
                        Ionicons.create_outline,
                        size: 23,
                        color: HexColor(secondaryColorLight),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  Container(
                    width: double.infinity,
                    height: 200.h,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/bar/bar3.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
            ),
            renderLineWidget(context),
            // Container(
            //   padding: EdgeInsets.zero,
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Container(
            //             margin: const EdgeInsets.only(top: 8),
            //             child: Text(
            //               "Huy hiệu: ".toUpperCase(),
            //               style: TextStyle(
            //                 fontSize: 13,
            //                 color: HexColor(greyTextColor),
            //               ),
            //             ),
            //           ),
            //           InkWell(
            //               child: Icon(
            //             Ionicons.create_outline,
            //             size: 23,
            //             color: HexColor(secondaryColorLight),
            //           ))
            //         ],
            //       ),
            //       const SizedBox(
            //         height: defaultPaddingItem,
            //       ),
            //       Container(
            //         width: 60.w,
            //         height: 60.w,
            //         padding: EdgeInsets.zero,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(60.w),
            //             image: const DecorationImage(
            //                 image: AssetImage("assets/images/bar/bar3.jpg"),
            //                 fit: BoxFit.cover)),
            //       ),
            //     ],
            //   ),
            // ),
            // renderLineWidget(context),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Ảnh dịch vụ: ".toUpperCase(),
                          style: TextStyle(
                            fontSize: 13,
                            color: HexColor(greyTextColor),
                          ),
                        ),
                      ),
                      InkWell(
                          child: Icon(
                        Ionicons.create_outline,
                        size: 23,
                        color: HexColor(secondaryColorLight),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: defaultPaddingItem,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Tất cả ảnh dịch vụ: ',
                      style: titleStyle.copyWith(
                          fontWeight: FontWeight.w400, height: 1.4),
                      children: const <TextSpan>[
                        TextSpan(
                            text: ' 100',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            renderLineWidget(context),
          ]),
        ));
  }
}

Widget renderLineWidget(BuildContext context) {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: kDefaultPaddingWidget.h),
      child: Container(
          padding: EdgeInsets.zero,
          height: 1,
          decoration:
              BoxDecoration(color: HexColor(greyTextColor).withOpacity(.5))));
}
