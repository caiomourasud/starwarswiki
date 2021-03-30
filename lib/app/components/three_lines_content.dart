import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

class ThreeLinesContent extends StatelessWidget {
  final int? id;
  final String? type;
  final Widget? topText;
  final String title;
  final Widget? subtitle;
  final String? tooltipButton;
  final Widget? button;

  const ThreeLinesContent(
      {Key? key,
      this.id,
      this.type,
      this.topText,
      required this.title,
      this.subtitle,
      this.tooltipButton,
      this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 5.0),
      if (id != null && type != null)
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: EdgeInsets.zero,
          child: Container(
            height: 70.0,
            width: 70.0,
            decoration: BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                  image: NetworkImage(
                      ImageGenerator.generateImage(id: id!, type: type!)),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      SizedBox(width: 12.0),
      Flexible(
        flex: 2,
        child: Container(
          height: 70.0,
          padding: EdgeInsets.only(top: 2.0, bottom: 4.0),
          child: Column(
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
              // if (subtitle != null) Flexible(flex: 2, child: Container()),
              if (subtitle != null) subtitle!,
            ],
          ),
        ),
      ),
      if (tooltipButton != null && button != null)
        MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(message: tooltipButton!, child: button)),
      SizedBox(width: 6.0)
    ]);
  }
}
