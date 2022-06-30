import 'package:client_tggt/core/style/app_text_style.dart';
import 'package:flutter/material.dart';

class OutlinedRoundedButton extends StatelessWidget {
  const OutlinedRoundedButton({
    Key? key,
    required this.label,
    required this.callback,
  }) : super(key: key);

  final String label;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: callback,
      child: Text(label, style: AppTextStyle().titleSemi16),
      style: OutlinedButton.styleFrom(
        //primary: ThemeServices().isDarkMode ? kColorTextDark : kColorTextLight,
        shape: const StadiumBorder(),
        textStyle: AppTextStyle().subtitleRegular14,
        backgroundColor: Colors.transparent,
        side: BorderSide(color: Theme.of(context).primaryColor, width: 1),
      ),
    );
  }
}
