import 'package:client_tggt/core/constant/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Lottie.asset(AppPath.appLoading, frameRate: FrameRate.max),
        height: 68.h,
        width: 100.w,
      ),
    );
  }
}
