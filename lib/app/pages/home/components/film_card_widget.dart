import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

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
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  height: 280.0,
                  width: 170.0,
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
      ),
    );
  }
}
