import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/film.dart';

class FilmCardWidget extends StatelessWidget {
  final Film film;
  final Function onTap;
  // final Function(int) onIconPressed;

  const FilmCardWidget({
    Key? key,
    required this.film,
    required this.onTap,
    // required this.onIconPressed
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onTap(),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film.title,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    'Episode ${film.episodeId}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(width: 4.0),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
