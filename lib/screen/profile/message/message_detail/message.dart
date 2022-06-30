import 'package:cached_network_image/cached_network_image.dart';
import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:client_tggt/screen/profile/message/message_detail/text_message.dart';
import 'package:flutter/material.dart';
import 'package:client_tggt/model/message/message_item_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Message extends StatelessWidget {
  const Message({Key? key, required this.message, this.isLast})
      : super(key: key);

  final MessageItemModel message;
  final bool? isLast;

  @override
  Widget build(BuildContext context) {
    // Widget messageContaint(ChatMessage message) {
    //   switch (message.messageType) {
    //     case ChatMessageType.text:
    //       return TextMessage(message: message);
    //     case ChatMessageType.audio:
    //       return AudioMessage(message: message);
    //     case ChatMessageType.video:
    //       return VideoMessage();
    //     default:
    //       return SizedBox();
    //   }
    // }
    return Container(
      padding: EdgeInsets.only(
        top: defaultPaddingItem.h,
      ),
      // margin: const EdgeInsets.only(bottom: kDefaultPaddingWidget),
      child: Row(
        mainAxisAlignment: message.isSender == true
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Visibility(
            visible: message.isSender == false,
            child: CachedNetworkImage(
              imageUrl: message.urlUserAvatar!,
              memCacheHeight: 200,
              placeholder: (context, url) => const CircularProgressIndicator(),
              imageBuilder: (context, image) => CircleAvatar(
                backgroundImage: image,
                radius: 20,
              ),
            ),
          ),
          Visibility(
              visible: message.isSender == false,
              child: SizedBox(
                width: defaultPaddingItem.w,
              )),
          Column(
            crossAxisAlignment: message.isSender == true
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              TextMessage(message: message),
              const SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.only(
                      right:
                          message.isSender == false ? 0 : defaultPaddingItem.w,
                      left:
                          message.isSender == false ? defaultPaddingItem.w : 0),
                  child: Row(
                    children: [
                      Text(
                        message.displayMessageTime,
                        style: AppTextStyle().eyebrowRegular10,
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

// class MessageStatusDot extends StatelessWidget {
//   final MessageStatus? status;

//   const MessageStatusDot({Key? key, this.status}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     Color dotColor(MessageStatus status) {
//       switch (status) {
//         case MessageStatus.not_sent:
//           return kErrorColor;
//         case MessageStatus.not_view:
//           return Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1);
//         case MessageStatus.viewed:
//           return kPrimaryColor;
//         default:
//           return Colors.transparent;
//       }
//     }

//     return Container(
//       margin: EdgeInsets.only(left: kDefaultPadding / 2),
//       height: 12,
//       width: 12,
//       decoration: BoxDecoration(
//         color: dotColor(status!),
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         status == MessageStatus.not_sent ? Icons.close : Icons.done,
//         size: 8,
//         color: Theme.of(context).scaffoldBackgroundColor,
//       ),
//     );
//   }
// }
