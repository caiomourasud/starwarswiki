import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/models/database/people.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../line_content.dart';

Converters conversores = Converters();

class CharacterListTileWidget extends StatefulWidget {
  final int personSelected;
  final People person;
  final Function(People) onTap;
  final Function(int) onFavoriteTap;

  const CharacterListTileWidget(
      {Key? key,
      required this.personSelected,
      required this.person,
      required this.onTap,
      required this.onFavoriteTap})
      : super(key: key);

  @override
  _CharacterListTileWidgetState createState() =>
      _CharacterListTileWidgetState();
}

class _CharacterListTileWidgetState extends State<CharacterListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        selected: widget.personSelected == widget.person.id &&
            MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          widget.onTap(widget.person);
        },
        subtitle: Container(
            height: 72.0,
            child: LineContent(
                id: widget.person.id,
                type: 'characters',
                topText: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(Converters().getSpecie(widget.person.species),
                          style: Theme.of(context).textTheme.overline),
                    ),
                    SizedBox(width: 2.0),
                    Converters().setGender(widget.person.gender, 8.0)
                  ],
                ),
                title: widget.person.name,
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
                                style: Theme.of(context).textTheme.overline),
                          ),
                          Text(Converters().toDouble(widget.person.height, 1),
                              style: Converters()
                                          .toDouble(widget.person.height, 1) ==
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
                            Converters().toDouble(widget.person.mass, 0),
                            style:
                                Converters().toDouble(widget.person.mass, 0) ==
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
                    widget.person.isFavorite ? 'Remove' : 'Make favorite',
                button: CupertinoButton(
                  minSize: 30,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                      widget.person.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      size: 28),
                  onPressed: () =>
                      setState(() => widget.onFavoriteTap(widget.person.id)),
                ))),
      ),
    );
  }
}
