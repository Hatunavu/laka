import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/screen/profile/message/message_detail/message.dart';
import 'package:client_tggt/services/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:client_tggt/model/message/message_item_model.dart';

class Body extends StatelessWidget {
  const Body({Key? key, this.listMessage, this.messageController})
      : super(key: key);
  final List<MessageItemModel>? listMessage;
  final ScrollController? messageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            color: ThemeServices().isDarkMode
                ? kColorBackgroundDark.withOpacity(.3)
                : Colors.grey[50],
            child: ListView.builder(
              shrinkWrap: true,
              controller: messageController,
              padding: EdgeInsets.zero,
              itemCount: listMessage!.length,
              itemBuilder: (context, index) => Message(
                message: listMessage![index],
                isLast: index == listMessage!.length - 1 ? true : false,
              ),
            ),
          ),
        ),
        // ChatInputField(),
      ],
    );
  }
}
