import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListFavoriteWidget extends StatelessWidget {
  final double paddingTop;
  final double paddingRight;
  final bool isSelected;
  final Function() onTap;

  const ListFavoriteWidget(
      {Key? key,
      required this.paddingTop,
      required this.paddingRight,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop, right: paddingRight),
          child: Tooltip(
              message: isSelected ? 'List all' : 'List favorites',
              child: CupertinoButton(
                  minSize: 34,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                      isSelected
                          ? CupertinoIcons.square_favorites_alt_fill
                          : CupertinoIcons.square_favorites_alt,
                      size: 28),
                  onPressed: () => onTap())),
        ));
  }
}
