import 'package:client_tggt/core/style/conver_time.dart';
import 'package:client_tggt/model/vendor/vendor_info_model.dart';

class MessageModel {
  final VendorModel ventor;
  final MessageItem lastMessage;
  final int unRead;

  MessageModel(
      {required this.ventor, required this.lastMessage, required this.unRead});
}

class MessageItem {
  final String message;
  final DateTime time;

  String get displayTimeComment => TimeAgo.timeAgoSinceDate(time);
  MessageItem({required this.message, required this.time});
}
