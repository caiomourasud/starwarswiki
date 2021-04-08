import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class CustomHorizontalList {
  Widget list(
      {required BuildContext context,
      required String title,
      required double height,
      required double width,
      double viewportFraction = 0.9,
      required List cards,
      required Function(int) card,
      required int rows,
      bool hasDivider = true,
      required bool seeAll,
      required Function onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasDivider) SizedBox(height: 8.0),
        if (hasDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Divider(height: 0),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.headline6),
              if (seeAll)
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text('See all',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Theme.of(context).accentColor)),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      onTap();
                    },
                  ),
                ),
              if (!seeAll)
                SizedBox(
                  height: 44.0,
                )
            ],
          ),
        ),
        Container(
            height: height,
            child: GridView.builder(
              controller: PageController(viewportFraction: viewportFraction),
              physics: MediaQuery.of(context).size.width <= sm
                  ? PageScrollPhysics()
                  : null,
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return card(index);
              },
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: rows / 4,
                maxCrossAxisExtent: height / rows,
                mainAxisExtent: (width / rows) - 0.10,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
              ),
              itemCount: cards.length,
            )),
        SizedBox(height: 24.0)
      ],
    );
  }
}
