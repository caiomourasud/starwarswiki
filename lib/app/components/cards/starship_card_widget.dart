import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/starship.dart';

import '../three_lines_content.dart';

class StarshipCardWidget extends StatelessWidget {
  final Starship starship;
  final Function onTap;

  const StarshipCardWidget({
    Key? key,
    required this.starship,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => onTap(),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ThreeLinesContent(
                id: starship.id,
                type: 'starships',
                topText: Opacity(
                  opacity: 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(starship.model,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.overline),
                      ),
                    ],
                  ),
                ),
                title: starship.name,
                subtitle: Opacity(
                  opacity: 0.6,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(starship.manufacturer,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  ),
                ),
                // tooltipButton:
                //     // starship.isFavorite ? 'Remover' :
                //     'Favoritar',
                // button: CupertinoButton(
                //   minSize: 30,
                //   padding: EdgeInsets.zero,
                //   borderRadius: BorderRadius.circular(50.0),
                //   child: Icon(
                //       //  starship.isFavorite
                //       //       ? CupertinoIcons.heart_fill
                //       //       :
                //       CupertinoIcons.heart,
                //       size: 28),
                //   onPressed: () {},
                // )
              ))),
    );
  }
}
