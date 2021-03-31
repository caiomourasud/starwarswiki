import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/utils/converters.dart';

import '../line_content.dart';

class CharacterCardWidget extends StatefulWidget {
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
  _CharacterCardWidgetState createState() => _CharacterCardWidgetState();
}

class _CharacterCardWidgetState extends State<CharacterCardWidget> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => widget.onTap(),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: LineContent(
                    id: widget.character.id,
                    type: 'characters',
                    topText: Row(
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                              Converters().setSpecie(widget.character.species),
                              style: Theme.of(context).textTheme.overline),
                        ),
                        SizedBox(width: 2.0),
                        Converters().setGender(widget.character.gender, 8.0)
                      ],
                    ),
                    title: widget.character.name,
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Text('Height',
                                    style:
                                        Theme.of(context).textTheme.overline),
                              ),
                              Text(
                                  Converters()
                                      .toDouble(widget.character.height, 1),
                                  style: Converters().toDouble(
                                              widget.character.height, 1) ==
                                          'unknown'
                                      ? Theme.of(context).textTheme.overline
                                      : Theme.of(context).textTheme.subtitle2),
                            ],
                          ),
                          SizedBox(width: 12.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Text('Mass',
                                    style:
                                        Theme.of(context).textTheme.overline),
                              ),
                              Text(
                                Converters().toDouble(widget.character.mass, 0),
                                style: Converters().toDouble(
                                            widget.character.mass, 0) ==
                                        'unknown'
                                    ? Theme.of(context).textTheme.overline
                                    : Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    tooltipButton:
                        widget.character.isFavorite ? 'Remover' : 'Favoritar',
                    button: CupertinoButton(
                      minSize: 30,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Icon(
                          widget.character.isFavorite
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          size: 28),
                      onPressed: () => setState(
                          () => widget.onIconPressed(widget.character.id)),
                    )))));
  }
}
