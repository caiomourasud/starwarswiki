import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/database/starship.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

Converters conversores = Converters();

class StarshipListTileWidget extends StatefulWidget {
  final int starshipSelected;
  final Starship starship;
  final Function(Starship) onTap;
  final Function(int) onFavoriteTap;

  const StarshipListTileWidget(
      {Key? key,
      required this.starshipSelected,
      required this.starship,
      required this.onTap,
      required this.onFavoriteTap})
      : super(key: key);

  @override
  _StarshipListTileWidgetState createState() => _StarshipListTileWidgetState();
}

class _StarshipListTileWidgetState extends State<StarshipListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: widget.starshipSelected == widget.starship.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          widget.onTap(widget.starship);
        },
        subtitle: Container(
            height: 70.0,
            child: LineContent(
                id: widget.starship.id,
                type: 'starships',
                topText: Opacity(
                  opacity: 0.8,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.starship.starshipClass,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.overline),
                      ),
                    ],
                  ),
                ),
                title: widget.starship.name,
                subtitle: Opacity(
                  opacity: 0.6,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.starship.model,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                    ],
                  ),
                ),
                tooltipButton:
                    widget.starship.isFavorite ? 'Remove' : 'Make favorite',
                button: CupertinoButton(
                  minSize: 30,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                      widget.starship.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      size: 28),
                  onPressed: () =>
                      setState(() => widget.onFavoriteTap(widget.starship.id)),
                ))),
      ),
    );
  }
}
