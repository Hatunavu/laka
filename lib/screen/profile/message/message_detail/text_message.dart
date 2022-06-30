import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:client_tggt/model/message/message_item_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    this.message,
  }) : super(key: key);

  final MessageItemModel? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPaddingWidget.w,
        vertical: kDefaultPadding.h / 1.5,
      ),
      decoration: BoxDecoration(
        color: message!.isSender == true
            ? Theme.of(context).primaryColor
            : ThemeServices().isDarkMode
                ? kColorBackgroundDark
                : Colors.grey[200],
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Text(
        message?.content ?? "",
        maxLines: 100,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            height: 1.5,
            color: message!.isSender == true ? Colors.white : Colors.black),
      ),
    );
  }
}
