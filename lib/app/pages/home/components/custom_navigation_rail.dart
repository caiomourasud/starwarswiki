import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../destination.dart';

class CustomNavigationRail extends StatelessWidget {
  final BoxConstraints dimens;
  final List<Destination> itens;
  final int indexSelected;
  final Function(int) onTap;

  const CustomNavigationRail(
      {Key? key,
      required this.dimens,
      required this.itens,
      required this.indexSelected,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: dimens.maxHeight),
          child: IntrinsicHeight(
            child: Material(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black38
                  : Colors.white38,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: itens.asMap().entries.map((destination) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CupertinoButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 28.0, horizontal: 20.0),
                          child: Icon(
                            destination.value.icon,
                            color: indexSelected != destination.key
                                ? CupertinoColors.inactiveGray
                                : null,
                          ),
                          onPressed: () => onTap(destination.key)),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
