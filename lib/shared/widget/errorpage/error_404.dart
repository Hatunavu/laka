import 'package:client_tggt/shared/widget/button/inkwell_button.dart';
import 'package:flutter/material.dart';

class Error404Screen extends StatelessWidget {
  const Error404Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/error/2_404 Error.png",
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
