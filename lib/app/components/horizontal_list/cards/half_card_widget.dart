import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../../utils/capitalize.dart';

class HalfCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final double? height;
  final double? width;
  final double? viewportFractionHeight;
  final Function onTap;

  const HalfCardWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.image,
      this.height = 200.0,
      this.width = 200.0,
      this.viewportFractionHeight = 0.45,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthPage = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onTap(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                if (image != '')
                  Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: widthPage <= sm
                            ? widthPage * viewportFractionHeight!
                            : height,
                        width: widthPage <= sm ? widthPage * 0.45 : width,
                        decoration: BoxDecoration(
                            color: CupertinoColors.darkBackgroundGray,
                            image: DecorationImage(
                                image: NetworkImage(image),
                                alignment: Alignment.center,
                                fit: BoxFit.cover)),
                      )),
                if (image == '')
                  Container(
                    height: widthPage <= sm
                        ? widthPage * viewportFractionHeight!
                        : height,
                    width: widthPage <= sm ? widthPage * 0.45 : width,
                    child: Center(
                      child: Text('no image',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              ?.copyWith(color: Colors.white)),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle2),
                      ),
                    ],
                  ),
                  Opacity(
                    opacity: 0.8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(subtitle.capitalize(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.overline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
