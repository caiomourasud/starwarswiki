import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

class FilmCardWidget extends StatelessWidget {
  final Film film;
  final Function onTap;

  const FilmCardWidget({
    Key? key,
    required this.film,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => onTap(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width <= sm
                          ? 260.0
                          : 230.0,
                      width: MediaQuery.of(context).size.width <= sm
                          ? MediaQuery.of(context).size.width * 0.45
                          : 150.0,
                      decoration: BoxDecoration(
                          color: CupertinoColors.darkBackgroundGray,
                          image: DecorationImage(
                            image: NetworkImage(ImageGenerator.generateImage(
                                id: film.id, type: 'films')),
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.1), BlendMode.xor),
                          )),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Opacity(
                opacity: 0.8,
                child: Text(
                  'Episode ${Converters().setRoman(film.episodeId)}',
                  style: Theme.of(context).textTheme.overline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(film.title,
                  style: Theme.of(context).textTheme.subtitle2),
            ),
          ],
        ),
      ),
    );
  }
}
