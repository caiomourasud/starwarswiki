import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class CustomSliverAppBar extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<Widget> actions;
  final bool? showActionListOnLargeSize;
  final double? position;
  final int backButton;

  const CustomSliverAppBar({
    Key? key,
    required this.context,
    required this.title,
    this.showActionListOnLargeSize = true,
    required this.actions,
    this.position,
    required this.backButton,
  }) : super(key: key);

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    return CupertinoSliverNavigationBar(
        leading: null,
        middle: position == null
            ? null
            : AnimatedOpacity(
                opacity: position! > 35.0 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 100),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black87
                                  : Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
        previousPageTitle: '',
        automaticallyImplyTitle: position == null ? true : false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        largeTitle: position == null
            ? Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black87
                        : Theme.of(context).colorScheme.onPrimary),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (position! <= 35.0)
                    Flexible(
                      child: Text(
                        title,
                        style: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black87
                                    : Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  if (position! <= 35.0 &&
                      (width <= md || showActionListOnLargeSize!))
                    Padding(
                      padding: EdgeInsets.only(right: width > md ? 6.0 : 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: actions,
                      ),
                    ),
                ],
              ),
        trailing: position == null
            ? null
            : width > md && !showActionListOnLargeSize!
                ? null
                : AnimatedOpacity(
                    opacity: position! > 35.0 ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 100),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: position! > 35.0 ? actions : [])),
        padding: EdgeInsetsDirectional.only(
            start: 0.0, top: 0.0, end: width > md ? 6.0 : 4.0, bottom: 0.0),
        border: Border.all(color: Colors.transparent));
  }
}
