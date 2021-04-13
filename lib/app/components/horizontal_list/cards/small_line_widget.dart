import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../cached_image_widget.dart';

class SmallLineWidget extends StatelessWidget {
  final Widget? topText;
  final String title;
  final Widget? subtitle;
  final String image;
  final double? height;
  final double? viewportFractionHeight;
  final Function onTap;
  final Widget? button;

  const SmallLineWidget(
      {Key? key,
      this.topText,
      required this.title,
      this.subtitle,
      required this.image,
      this.height = 70.0,
      this.viewportFractionHeight = 0.27,
      required this.onTap,
      this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => onTap(),
          child: Row(children: [
            SizedBox(width: 5.0),
            Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: EdgeInsets.zero,
              child: Container(
                  height: height,
                  width: height,
                  child: CachedImageWidget(url: image)),
            ),
            SizedBox(width: 12.0),
            Flexible(
              flex: 2,
              child: Container(
                height: height!,
                // padding: EdgeInsets.only(bottom: 2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (topText != null) topText!,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(height: 1.2),
                          ),
                        ),
                      ],
                    ),
                    if (subtitle != null) subtitle!,
                  ],
                ),
              ),
            ),
            if (button != null) button!,
            SizedBox(width: 6.0)
          ])),
    );
  }
}
