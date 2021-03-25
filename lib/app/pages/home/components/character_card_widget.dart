import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/utils/converters.dart';

class CharacterCardWidget extends StatelessWidget {
  final People character;
  final Function onTap;
  final Function(int) onIconPressed;

  const CharacterCardWidget(
      {Key? key,
      required this.character,
      required this.onTap,
      required this.onIconPressed})
      : super(key: key);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    character.name,
                    style: Theme.of(context).textTheme.subtitle2,
                  )),
                  SizedBox(width: 4.0),
                  Converters().setGender(character.gender, 12.0)
                ],
              ),
              Text(Converters().setSpecie(character.species),
                  style: Theme.of(context).textTheme.caption),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Height',
                              style: Theme.of(context).textTheme.overline),
                          Text(Converters().toDouble(character.height, 1),
                              style:
                                  Converters().toDouble(character.height, 1) ==
                                          'unknown'
                                      ? Theme.of(context).textTheme.overline
                                      : null),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mass',
                              style: Theme.of(context).textTheme.overline),
                          Text(
                            Converters().toDouble(character.mass, 0),
                            style: Converters().toDouble(character.mass, 0) ==
                                    'unknown'
                                ? Theme.of(context).textTheme.overline
                                : null,
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0)
                    ],
                  ),
                  MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Tooltip(
                          message:
                              character.isFavorite ? 'Remover' : 'Favoritar',
                          child: CupertinoButton(
                              minSize: 30,
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(50.0),
                              child: Icon(
                                  character.isFavorite
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  size: 28),
                              onPressed: () => onIconPressed(character.id))))
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
