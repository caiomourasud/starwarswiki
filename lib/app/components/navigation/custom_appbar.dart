import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int backButton;
  final Color backgroundColor;
  final Widget? trailing;

  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.backButton,
      required this.backgroundColor,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CupertinoNavigationBar(
        automaticallyImplyLeading:
            width <= md || (width > md && backButton == 2),
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        transitionBetweenRoutes: width <= md,
        middle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black87
                      : Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
        trailing: trailing == null
            ? null
            : MouseRegion(cursor: SystemMouseCursors.click, child: trailing),
        border: Border.all(color: Colors.transparent));
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
