import 'package:client_tggt/core/constant/app_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingPrimaryScreen extends StatefulWidget {
  const LoadingPrimaryScreen({Key? key}) : super(key: key);

  @override
  _LoadingPrimaryScreenState createState() => _LoadingPrimaryScreenState();
}

class _LoadingPrimaryScreenState extends State<LoadingPrimaryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: Center(
              child: SvgPicture.asset(
                AppPath.logo,
                color: Theme.of(context).primaryColor,
                width: 100.w,
                // height: 60,
              ),
            )));
  }
}
// child: Lottie.asset("assets/splash/data.json", frameRate: FrameRate.max),
