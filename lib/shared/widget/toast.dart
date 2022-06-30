import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

abstract class IToast {
  void show({
    required String? title,
    required String? message,
    Duration? duration,
    bool hasDismissButton = true,
    Function() onClose,
  });

  void dismiss();
}

class CustomBotToast implements IToast {
  CancelFunc? _cancel;

  @override
  void show({
    required String? title,
    required String? message,
    Duration? duration,
    bool hasDismissButton = true,
    Function()? onClose,
  }) {
    _cancel = BotToast.showSimpleNotification(
      title: title!,
      subTitle: message,
      subTitleStyle: const TextStyle(color: Colors.black87),
      duration: duration,
      backgroundColor: Colors.white.withOpacity(0.95),
      borderRadius: 10.0,
      closeIcon: const Icon(
        Icons.close,
        size: 20.0,
      ),
      hideCloseButton: !hasDismissButton,
      onClose: onClose,
    );
  }

  @override
  void dismiss() {
    _cancel?.call();
  }
}
