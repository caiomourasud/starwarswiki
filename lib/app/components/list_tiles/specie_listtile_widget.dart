import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/database/specie.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../../utils/capitalize.dart';
import '../favorite_button_widget.dart';

Converters conversores = Converters();

class SpecieListTileWidget extends StatefulWidget {
  final int specieSelected;
  final Specie specie;
  final Function(Specie) onTap;
  final Function(int) onFavoriteTap;

  const SpecieListTileWidget(
      {Key? key,
      required this.specieSelected,
      required this.specie,
      required this.onTap,
      required this.onFavoriteTap})
      : super(key: key);

  @override
  _SpecieListTileWidgetState createState() => _SpecieListTileWidgetState();
}

class _SpecieListTileWidgetState extends State<SpecieListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: widget.specieSelected == widget.specie.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          widget.onTap(widget.specie);
        },
        subtitle: Container(
            height: 50.0,
            child: LineContent(
                id: widget.specie.id,
                type: 'species',
                title: widget.specie.name,
                subtitle: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(widget.specie.classification.capitalize(),
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ],
                ),
                button: FavoriteButtonWidget(
                    isFavorite: widget.specie.isFavorite,
                    onPressed: () => setState(
                        () => widget.onFavoriteTap(widget.specie.id))))),
      ),
    );
  }
}
