import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

Converters conversores = Converters();

class StarshipListTileWidget extends StatelessWidget {
  final Starship starshipSelected;
  final Starship starship;
  final Function(Starship) onTap;

  const StarshipListTileWidget(
      {Key? key,
      required this.starshipSelected,
      required this.starship,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: starshipSelected == starship &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          onTap(starship);
        },
        subtitle: Container(
            height: 70.0,
            child: LineContent(
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
                ))),
      ),
    );
  }
}
