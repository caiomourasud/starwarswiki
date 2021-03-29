import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  height: 80.0,
                  width: 76.0,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      image: DecorationImage(
                        image: NetworkImage(ImageGenerator.generateImage(
                            id: widget.character.id, type: 'characters')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              SizedBox(width: 4.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    Text(
                      widget.character.name,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: Text('Height',
                                  style: Theme.of(context).textTheme.overline),
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
                                  style: Theme.of(context).textTheme.overline),
                            ),
                            Text(
                              Converters().toDouble(widget.character.mass, 0),
                              style: Converters()
                                          .toDouble(widget.character.mass, 0) ==
                                      'unknown'
                                  ? Theme.of(context).textTheme.overline
                                  : Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Tooltip(
                      message:
                          widget.character.isFavorite ? 'Remover' : 'Favoritar',
                      child: CupertinoButton(
                          minSize: 30,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(50.0),
                          child: Icon(
                              widget.character.isFavorite
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              size: 28),
                          onPressed: () => setState(() =>
                              widget.onIconPressed(widget.character.id))))),
              SizedBox(
                  width:
                      MediaQuery.of(context).size.width <= 420.0 ? 4.0 : 16.0)
            ],
          ),
        ),
      ),
    );
  }
}
