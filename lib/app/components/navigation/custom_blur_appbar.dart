import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomBlurAppBar extends StatelessWidget {
  final String title;
  final double position;

  const CustomBlurAppBar({
    Key? key,
    required this.title,
    required this.position,
  }) : super(key: key);

  @override
  Widget build(context) {
    return CupertinoSliverNavigationBar(
        automaticallyImplyLeading: false,
        automaticallyImplyTitle: true,
        middle: position > 37.0
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,
                      style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black87
                                  : title == 'StarWars'
                                      ? Colors.yellow[600]
                                      : Colors.white)),
                ],
              )
            : null,
        stretch: true,
        // heroTag: title,
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withAlpha(220),
        largeTitle: Text(title,
            style: TextStyle(
                fontSize: 34.0 +
                    (position < 0.0
                        ? position.abs() / 60.0 > 4.0
                            ? 4.0
                            : position.abs() / 60.0
                        : 0.0),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black87
                    : title == 'StarWars'
                        ? Colors.yellow[600]
                        : Colors.white)),
        border: Border.all(color: Colors.transparent));
  }
}
