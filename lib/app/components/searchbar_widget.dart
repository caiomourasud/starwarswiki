import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchBarWidget extends SliverPersistentHeaderDelegate {
  final size;
  final buscar;
  final focus;
  final onChange;
  final Function() cancelar;
  final texto;
  final fullDimens;
  final int backButton;
  SearchBarWidget(
      {this.size,
      this.buscar,
      this.focus,
      this.onChange,
      required this.cancelar,
      this.texto = 'Buscar',
      this.fullDimens,
      required this.backButton});

  @override
  Widget build(context, shrinkOffset, overlapsContent) => Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints dimens) {
          return Container(
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    AnimatedContainer(
                        width: (dimens.maxWidth - 28) - size,
                        margin: EdgeInsets.only(
                            left: 14.0, right: 12.0, bottom: 2.0),
                        child: CupertinoSearchTextField(
                          padding: EdgeInsets.fromLTRB(
                              3.8,
                              focus.hasFocus
                                  ? 8.0
                                  : 8.0 -
                                      (shrinkOffset <= 31.0
                                          ? (shrinkOffset / 4)
                                          : 0.0),
                              5,
                              focus.hasFocus
                                  ? 8.0
                                  : 8.0 -
                                      (shrinkOffset <= 31.0
                                          ? (shrinkOffset / 4)
                                          : 0.0)),
                          controller: buscar,
                          focusNode: focus,
                          placeholder: texto,
                          onChanged: onChange,
                          onSubmitted: onChange,
                          placeholderStyle: TextStyle(
                            color: shrinkOffset <= 26.0 || minExtent == 48.0
                                ? CupertinoColors.secondaryLabel
                                : Colors.transparent,
                          ),
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.black87
                                  : Theme.of(context).colorScheme.onPrimary),
                          itemColor: shrinkOffset <= 26.0 || minExtent == 48.0
                              ? CupertinoColors.secondaryLabel
                              : Colors.transparent,
                        ),
                        duration: Duration(milliseconds: 200)),
                    AnimatedOpacity(
                      opacity:
                          size != 0.0 || buscar.text.isNotEmpty ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 300),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: CupertinoButton(
                          child: Text('Cancel',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                      color: Theme.of(context).accentColor)),
                          padding: EdgeInsets.only(bottom: 2.0),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            cancelar();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      );

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => size == 0.0 ? 0.0 : 48.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
