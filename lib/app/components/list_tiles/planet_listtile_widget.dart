import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/database/planet.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../utils/capitalize.dart';
import '../favorite_button_widget.dart';

Converters conversores = Converters();

class PlanetListTileWidget extends StatefulWidget {
  final int planetSelected;
  final Planet planet;
  final Function(Planet) onTap;
  final Function(int) onFavoriteTap;

  const PlanetListTileWidget(
      {Key? key,
      required this.planetSelected,
      required this.planet,
      required this.onTap,
      required this.onFavoriteTap})
      : super(key: key);

  @override
  _PlanetListTileWidgetState createState() => _PlanetListTileWidgetState();
}

class _PlanetListTileWidgetState extends State<PlanetListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: widget.planetSelected == widget.planet.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          widget.onTap(widget.planet);
        },
        subtitle: Container(
            height: 50.0,
            child: LineContent(
                id: widget.planet.id,
                type: 'planets',
                title: widget.planet.name,
                subtitle: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(widget.planet.climate.capitalize(),
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
                button: FavoriteButtonWidget(
                    isFavorite: widget.planet.isFavorite,
                    onPressed: () => setState(
                        () => widget.onFavoriteTap(widget.planet.id))))),
      ),
    );
  }
}
