import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/utils/conversores.dart';
import 'package:starwarswiki/code/breakpoints.dart';
import 'package:starwarswiki/db/people_table.dart';

Conversores conversores = Conversores();

class ListTileWidget extends StatelessWidget {
  final PeopleTable personSelected;
  final PeopleTable person;
  final BoxConstraints dimens;
  final Function(PeopleTable) onTap;

  const ListTileWidget(
      {Key? key,
      required this.personSelected,
      required this.person,
      required this.dimens,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: ListTile(
          selected: personSelected == person && dimens.maxWidth > md,
          selectedTileColor: Theme.of(context).focusColor,
          contentPadding: EdgeInsets.fromLTRB(4.0, 8.0, 13.0, 8.0),
          onTap: () {
            onTap(person);
          },
          title: Row(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0),
                  child: conversores.setGender(person.gender, 16.0)),
              Flexible(
                child: Text(
                  person.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: 40.0,
                  child: ListView(
                    padding: EdgeInsets.only(top: 4.0),
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.resize_v,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Altura',
                                  style: Theme.of(context).textTheme.caption),
                              Text('${conversores.toDouble(person.height, 1)}',
                                  style:
                                      '${conversores.toDouble(person.height, 1)}' !=
                                              'Desconhecido'
                                          ? Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                          : Theme.of(context)
                                              .textTheme
                                              .caption),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Container(
                              height: 20.0,
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: Icon(
                              CupertinoIcons.timer,
                              size: 22,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Peso',
                                  style: Theme.of(context).textTheme.caption),
                              Text('${conversores.toDouble(person.mass, 0)}',
                                  style:
                                      '${conversores.toDouble(person.mass, 0)}' !=
                                              'Desconhecido'
                                          ? Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                          : Theme.of(context)
                                              .textTheme
                                              .caption),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Tooltip(
                message: person.isFavorite ? 'Remover' : 'Favoritar',
                child: Theme(
                  data: ThemeData(
                      brightness: Brightness.dark,
                      splashColor: Colors.transparent),
                  child: IconButton(
                    splashRadius: 22.0,
                    icon: Icon(
                        person.isFavorite
                            ? CupertinoIcons.suit_heart_fill
                            : CupertinoIcons.suit_heart,
                        color: Colors.red[600]),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
