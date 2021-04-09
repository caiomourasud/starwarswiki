import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/line_content.dart';
import 'package:starwarswiki/app/models/database/film.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

Converters conversores = Converters();

class FilmListTileWidget extends StatefulWidget {
  final int filmSelected;
  final Film film;
  final Function(Film) onTap;
  final Function(int) onFavoriteTap;

  const FilmListTileWidget(
      {Key? key,
      required this.filmSelected,
      required this.film,
      required this.onTap,
      required this.onFavoriteTap})
      : super(key: key);

  @override
  _FilmListTileWidgetState createState() => _FilmListTileWidgetState();
}

class _FilmListTileWidgetState extends State<FilmListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: widget.filmSelected == widget.film.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          widget.onTap(widget.film);
        },
        subtitle: Container(
          height: 70.0,
          child: LineContent(
              id: widget.film.id,
              type: 'films',
              topText: Row(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                        'Episode ${Converters().setRoman(widget.film.episodeId)}',
                        style: Theme.of(context).textTheme.overline),
                  ),
                ],
              ),
              title: widget.film.title,
              subtitle: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Opacity(
                      opacity: 0.8,
                      child: Row(
                        children: [
                          Text('Director',
                              style: Theme.of(context).textTheme.overline)
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(widget.film.director,
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                ],
              ),
              tooltipButton:
                  widget.film.isFavorite ? 'Remove' : 'Make favorite',
              button: CupertinoButton(
                minSize: 30,
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(50.0),
                child: Icon(
                    widget.film.isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    size: 28),
                onPressed: () =>
                    setState(() => widget.onFavoriteTap(widget.film.id)),
              )),
        ),
      ),
    );
  }
}
