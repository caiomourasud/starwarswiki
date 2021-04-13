import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'cached_image_widget.dart';

class LineContent extends StatelessWidget {
  final int? id;
  final String? type;
  final Widget? topText;
  final String title;
  final Widget? subtitle;
  final Widget? button;

  const LineContent(
      {Key? key,
      this.id,
      this.type,
      this.topText,
      required this.title,
      this.subtitle,
      this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = subtitle == null || topText == null ? 50.0 : 72.0;
    double width = subtitle == null || topText == null ? 50.0 : 72.0;
    return Row(children: [
      SizedBox(width: 5.0),
      if (id != null && type != null)
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.zero,
          child: Container(
              height: height,
              width: width,
              child: CachedImageWidget(id: id!, type: type!)),
        ),
      SizedBox(width: 12.0),
      Flexible(
        flex: 2,
        child: Container(
          height: height - 2.0,
          padding: EdgeInsets.only(top: 2.0, bottom: 4.0),
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
                      style: Theme.of(context).textTheme.subtitle2,
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
    ]);
  }
}
