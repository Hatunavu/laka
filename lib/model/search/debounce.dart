import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  final int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  Debounce({this.milliseconds = 500, this.action, this.timer});

  void run(VoidCallback action) {
    if (timer?.isActive ?? false) timer!.cancel();
    timer = Timer(Duration(milliseconds: milliseconds!), action);
  }

  // void dispose() => timer!.cancel();
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
  }
}
