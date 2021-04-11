import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final bool isFavorite;
  final Function onPressed;

  const FavoriteButtonWidget(
      {Key? key, required this.isFavorite, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: isFavorite ? 'Remove' : 'Make favorite',
        child: CupertinoButton(
            minSize: 30,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(50.0),
            child: Icon(
                isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                size: 28,
                color: isFavorite
                    ? null
                    : Theme.of(context).colorScheme.onSurface.withAlpha(120)),
            onPressed: () => onPressed()));
  }
}
