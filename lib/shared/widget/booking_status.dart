import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:client_tggt/model/vendor_page/booking/enum_booking_status.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BookingStatusWidget extends StatelessWidget {
  const BookingStatusWidget({Key? key, required this.type}) : super(key: key);
  final BookingStatus type;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: getStatus(context, type),
    );
  }
}

enum bookingStatus { pending, canceled, confirmed, complete }

Widget getStatus(BuildContext context, BookingStatus status) {
  // const status = bookingStatus.pending;
  switch (status) {
    case BookingStatus.pending:
      return Text("Chờ xác nhận",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: HexColor("#980200")));
    case BookingStatus.completed:
      return Text("Hoàn thành",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: Colors.green));
    case BookingStatus.reviewed:
      return Text("Hoàn thành",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: Colors.green));
    case BookingStatus.confirmed:
      return Text("Đã xác nhận",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: kColorPrimaryLight));
    case BookingStatus.canceled:
      return Text("Đã huỷ",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: Colors.red));

    case BookingStatus.checkedIn:
      return Text("Đang sử dụng dịch vụ",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: Colors.red));

    case BookingStatus.billPending:
      return Text("Chờ khách hàng xác nhận",
          style: titleStyle.copyWith(
              fontWeight: FontWeight.w400, color: const Color(0xFF980200)));
    default:
      return Container();
  }
}
