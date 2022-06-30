import 'package:auto_route/auto_route.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/extensions/currency_formatting.dart';
import 'package:client_tggt/model/vendor_page/booking/sub_fee/sub_fee_model.dart';
import 'package:client_tggt/shared/base_screen.dart';
import 'package:client_tggt/shared/widget/button/inkwell_button_loading.dart';
import 'package:client_tggt/shared/widget/textfield/secondary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AddSubFeeScreen extends StatefulWidget {
  AddSubFeeScreen({Key? key, this.onBack}) : super(key: key);
  final Function(String name, double price, String note)? onBack;
  @override
  State<AddSubFeeScreen> createState() => _AddSubFeeScreenState();
}

class _AddSubFeeScreenState extends State<AddSubFeeScreen> {
  final subFeeNameController = TextEditingController(text: "");
  final subFeePriceController = TextEditingController(text: "0");
  final subFeeNoteController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        title: "Thêm menu",
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Icon(
            Ionicons.chevron_back_outline,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        child: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPaddingScreen.w,
                vertical: kDefaultPaddingWidget.h),
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        height: kDefaultPaddingWidget.h,
                      ),
                      SecondaryTextfield(
                          label: "Tên phụ phí",
                          onChanged: (text) {
                            // controller.handleCheckInformation();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Tên món ăn là bắt buộc";
                            }
                            return null;
                          },
                          controller: subFeeNameController),
                      SizedBox(
                        height: kDefaultPaddingWidget.h * 1.5,
                      ),
                      SecondaryTextfield(
                          label: "Giá (vnđ)",
                          isNumber: true,
                          onChanged: (string) {
                            if (string.split("").length > 4) {
                              final priceString = string.replaceAll(".", "");
                              subFeePriceController.text =
                                  int.parse(priceString).formatCurrency2();
                              subFeePriceController.selection =
                                  TextSelection.fromPosition(TextPosition(
                                      offset: subFeePriceController
                                          .value.text.length));
                            }
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == "0") {
                              return "Giá món ăn là bắt buộc";
                            }
                            return null;
                          },
                          controller: subFeePriceController),
                      SizedBox(
                        height: kDefaultPaddingWidget.h * 1.5,
                      ),
                      SecondaryTextfield(
                          label: "Chú thích",
                          minLines: 3,
                          maxLines: 10,
                          onChanged: (text) {
                            // controller.handleCheckInformation();
                          },
                          controller: subFeeNoteController),
                      SizedBox(
                        height: kDefaultPaddingWidget.h,
                      ),
                    ]),
                  ),
                ),
                InkwellButtonLoading(
                    label: "Xác nhận",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await widget.onBack?.call(
                            subFeeNameController.text,
                            double.parse(
                                subFeePriceController.text.replaceAll(".", "")),
                            subFeeNoteController.text);
                        context.router.pop();
                      }
                    })
              ],
            )));
  }
}
