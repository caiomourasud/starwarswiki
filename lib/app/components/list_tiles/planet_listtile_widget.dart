import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../utils/capitalize.dart';

Converters conversores = Converters();

class PlanetListTileWidget extends StatelessWidget {
  final int planetSelected;
  final Planet planet;
  final Function(Planet) onTap;

  const PlanetListTileWidget(
      {Key? key,
      required this.planetSelected,
      required this.planet,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: planetSelected == planet.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          onTap(planet);
        },
        subtitle: Container(
            height: 50.0,
            child: LineContent(
                id: planet.id,
                type: 'planets',
                title: planet.name,
                subtitle: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(planet.climate.capitalize(),
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ))),
      ),
    );
  }
}
