import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  const SomethingWentWrongScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error/3_Something Went Wrong.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: InkWellButton(
              label: "TRY AGAIN",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
