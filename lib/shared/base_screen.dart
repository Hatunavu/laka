import 'package:client_tggt/core/constant/constant.dart';
import 'package:client_tggt/core/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(
      {Key? key,
      this.title,
      this.leading,
      this.trailing,
      required this.child,
      this.elevation = kdefaultElevated,
      this.onPress,
      this.titleWidget,
      this.floatingActionButton,
      this.backgroundColor,
      this.titleColor})
      : super(key: key);

  final String? title;
  final List<Widget>? trailing;
  final Widget? leading;
  final Widget child;
  final double? elevation;
  final Function()? onPress;
  final Widget? titleWidget;
  final Widget? floatingActionButton;
  final Color? backgroundColor;
  final Color? titleColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: title != null
          ? AppBar(
              backgroundColor: backgroundColor,
              actions: trailing,
              leading: leading,
              automaticallyImplyLeading: leading != null ? true : false,
              elevation: elevation,
              centerTitle: true,
              title: Text(title!,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: titleColor ?? appBarTitleColor)))
          : null,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: GestureDetector(
          child: child,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
        ),
      ),
    );
  }
}
