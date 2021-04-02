import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomSliverAppBar extends StatelessWidget {
  final BuildContext context;
  final String title;
  final List<Widget> titleActions;
  final List<Widget> actions;
  final double? position;
  final int backButton;

  const CustomSliverAppBar({
    Key? key,
    required this.context,
    required this.title,
    required this.titleActions,
    required this.actions,
    this.position,
    required this.backButton,
  }) : super(key: key);

  @override
  Widget build(context) {
    return CupertinoSliverNavigationBar(
        stretch: true,
        // heroTag: 'test',
        middle: position == null
            ? null
            : AnimatedOpacity(
                opacity: position! > 35.0 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 100),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black87
                          : Theme.of(context).colorScheme.onPrimary),
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
                  if (position! <= 35.0)
                    Row(
                      children: titleActions,
                    )
                ],
              ),
        trailing: position == null
            ? null
            : AnimatedOpacity(
                opacity: position! > 35.0 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 100),
                child: Row(mainAxisSize: MainAxisSize.min, children: actions)),
        border: Border.all(color: Colors.transparent));
  }
}
