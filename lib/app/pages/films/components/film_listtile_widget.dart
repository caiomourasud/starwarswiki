import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/three_lines_content.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

Converters conversores = Converters();

class FilmListTileWidget extends StatelessWidget {
  final Film filmSelected;
  final Film film;
  final Function(Film) onTap;

  const FilmListTileWidget(
      {Key? key,
      required this.filmSelected,
      required this.film,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected:
            filmSelected == film && MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          onTap(film);
        },
        subtitle: Container(
            height: 70.0,
            child: ThreeLinesContent(
              id: film.id,
              type: 'films',
              topText: Row(
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                        'Episode ${Converters().setRoman(film.episodeId)}',
                        style: Theme.of(context).textTheme.overline),
                  ),
                ],
              ),
              title: film.title,
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
                      Text(film.director,
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
