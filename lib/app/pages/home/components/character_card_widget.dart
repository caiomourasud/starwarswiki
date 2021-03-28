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
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: [
                Container(
                  height: 180.0,
                  width: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      image: DecorationImage(
                        image: NetworkImage(ImageGenerator.generateImage(
                            id: widget.character.id, type: 'characters')),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.xor),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                              child: Text(
                            widget.character.name,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: Colors.white),
                          )),
                          SizedBox(width: 4.0),
                          Converters().setGender(widget.character.gender, 12.0)
                        ],
                      ),
                      Text(Converters().setSpecie(widget.character.species),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: Colors.white)),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          ?.copyWith(color: Colors.white)),
                                  Text(
                                      Converters()
                                          .toDouble(widget.character.height, 1),
                                      style: Converters().toDouble(
                                                  widget.character.height, 1) ==
                                              'unknown'
                                          ? Theme.of(context)
                                              .textTheme
                                              .overline
                                              ?.copyWith(color: Colors.white)
                                          : TextStyle(color: Colors.white)),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mass',
                                      style: Theme.of(context)
                                          .textTheme
                                          .overline
                                          ?.copyWith(color: Colors.white)),
                                  Text(
                                    Converters()
                                        .toDouble(widget.character.mass, 0),
                                    style: Converters().toDouble(
                                                widget.character.mass, 0) ==
                                            'unknown'
                                        ? Theme.of(context)
                                            .textTheme
                                            .overline
                                            ?.copyWith(color: Colors.white)
                                        : TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.0)
                            ],
                          ),
                          MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Tooltip(
                                  message: widget.character.isFavorite
                                      ? 'Remover'
                                      : 'Favoritar',
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
                                          widget.onIconPressed(
                                              widget.character.id)))))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
