import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/vendor_page/booking/booking_item_model.dart';
import 'package:client_tggt/router/router.gr.dart';
import 'package:client_tggt/screen/vendors/booking/detail/booking_detail_controller.dart';
import 'package:client_tggt/screen/vendors/booking/vendor_booking_controller.dart';
import 'package:client_tggt/shared/widget/booking_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class BookingItem extends StatelessWidget {
  const BookingItem(
      {Key? key, required this.bookingItem, required this.controller})
      : super(key: key);
  final BookingItemModel bookingItem;
  final VendorBookingController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.router
              .push(BookingDetailPage(
                  bookingId: bookingItem.id,
                  parentPage: "booking_list",
                  onBack: (BookingItemModel orderItem) {
                    inspect(orderItem);
                    controller.handleUpdateListBooking(orderItem);
                  }))
              .then((value) {
            Get.delete<BookingDetailController>();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: defaultPaddingItem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bookingItem.orderId!,
                      style: titleStyle,
                    ),
                    BookingStatusWidget(type: bookingItem.status)
                  ],
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    color: HexColor(greyTextColor).withOpacity(.5)),
              ),
              const SizedBox(
                height: defaultPaddingItem,
              ),
              Row(
                children: [
                  Container(
                    height: 110.w,
                    width: 110.w,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        image: DecorationImage(
                            // image: AssetImage("assets/images/bar/bar1.jpg"),
                            image: CachedNetworkImageProvider(
                                bookingItem.product!.thumbnail!.path ?? ""),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: defaultPaddingItem,
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    height: 110.w,
                    child: Column(
                      mainAxisAlignment: bookingItem.customer == null
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: bookingItem.customer == null
                              ? kDefaultPaddingItem.h
                              : 0,
                        ),

                        Container(
                            padding: EdgeInsets.zero,
                            width: (MediaQuery.of(context).size.width -
                                defaultPaddingItem * 2 -
                                110.w -
                                defaultPaddingItem),
                            child: Wrap(children: [
                              Text(
                                bookingItem.product?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ])),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       bookingItem.product!.name,
                        //       style: const TextStyle(
                        //           fontSize: 16, fontWeight: FontWeight.bold),
                        //     )
                        //   ],
                        // ),
                        bookingItem.customer == null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Ionicons.person_circle_outline,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: defaultPaddingItem,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            bookingItem
                                                .customer!.profile!.fullName!,
                                            style: bookContentStyle),
                                      )
                                    ],
                                  )
                                ],
                              ),
                        bookingItem.customer == null
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Ionicons.call_outline,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: defaultPaddingItem,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            '${bookingItem.customer!.phone}',
                                            style: bookContentStyle),
                                      )
                                    ],
                                  )
                                ],
                              ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Ionicons.time_outline,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: defaultPaddingItem,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.h),
                                  child:
                                      // Text("10/12/2021 20:00",
                                      //     style: bookContentStyle),

                                      RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                      style: bookContentStyle,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: DateFormat("hh:mm ")
                                                .format(bookingItem.orderAt!)),
                                        TextSpan(text: "day".tr + " "),
                                        TextSpan(
                                            text: DateFormat("dd-MM-yyy")
                                                .format(bookingItem.orderAt!))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
