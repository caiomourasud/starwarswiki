import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/three_lines_content.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/breakpoints.dart';
import 'package:starwarswiki/app/models/people.dart';

Converters conversores = Converters();

class CharacterListTileWidget extends StatelessWidget {
  final People personSelected;
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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected:
            personSelected == person && MediaQuery.of(context).size.width > md,
        selectedTileColor: Theme.of(context).focusColor,
        contentPadding: EdgeInsets.fromLTRB(14.0, 2.0, 12.0, 2.0),
        onTap: () {
          onTap(person);
        },
        subtitle: Container(
            height: 70.0,
            child: ThreeLinesContent(
                id: person.id,
                type: 'characters',
                topText: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(Converters().setSpecie(person.species),
                          style: Theme.of(context).textTheme.overline),
                    ),
                    SizedBox(width: 2.0),
                    Converters().setGender(person.gender, 8.0)
                  ],
                ),
                title: person.name,
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
                          Text(Converters().toDouble(person.height, 1),
                              style: Converters().toDouble(person.height, 1) ==
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
                            Converters().toDouble(person.mass, 0),
                            style: Converters().toDouble(person.mass, 0) ==
                                    'unknown'
                                ? Theme.of(context).textTheme.overline
                                : Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                tooltipButton: person.isFavorite ? 'Remover' : 'Favoritar',
                button: CupertinoButton(
                  minSize: 30,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                      person.isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      size: 28),
                  onPressed: () => onFavoriteTap(person.id),
                ))
            // Row(
            //   children: [
            //     Card(
            //       semanticContainer: true,
            //       clipBehavior: Clip.antiAliasWithSaveLayer,
            //       margin: EdgeInsets.zero,
            //       child: Container(
            //         height: 70.0,
            //         width: 70.0,
            //         decoration: BoxDecoration(
            //             color: Colors.black87,
            //             image: DecorationImage(
            //               image: NetworkImage(ImageGenerator.generateImage(
            //                   id: person.id, type: 'characters')),
            //               alignment: Alignment.topCenter,
            //               fit: BoxFit.cover,
            //             )),
            //       ),
            //     ),
            //     SizedBox(width: 12.0),
            //     Flexible(
            //       flex: 2,
            //       child: Column(
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Opacity(
            //                     opacity: 0.8,
            //                     child: Text(
            //                         Converters().setSpecie(person.species),
            //                         style:
            //                             Theme.of(context).textTheme.overline),
            //                   ),
            //                   SizedBox(width: 2.0),
            //                   Converters().setGender(person.gender, 8.0)
            //                 ],
            //               ),
            //               Text(
            //                 person.name,
            //                 style: Theme.of(context).textTheme.subtitle2,
            //               ),
            //             ],
            //           ),
            //           Flexible(flex: 2, child: Container()),
            //           Row(
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Opacity(
            //                     opacity: 0.8,
            //                     child: Text('Height',
            //                         style:
            //                             Theme.of(context).textTheme.overline),
            //                   ),
            //                   Text(Converters().toDouble(person.height, 1),
            //                       style: Converters()
            //                                   .toDouble(person.height, 1) ==
            //                               'unknown'
            //                           ? Theme.of(context).textTheme.overline
            //                           : Theme.of(context).textTheme.subtitle2),
            //                 ],
            //               ),
            //               SizedBox(width: 12.0),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Opacity(
            //                     opacity: 0.8,
            //                     child: Text('Mass',
            //                         style:
            //                             Theme.of(context).textTheme.overline),
            //                   ),
            //                   Text(
            //                     Converters().toDouble(person.mass, 0),
            //                     style: Converters().toDouble(person.mass, 0) ==
            //                             'unknown'
            //                         ? Theme.of(context).textTheme.overline
            //                         : Theme.of(context).textTheme.subtitle2,
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //     MouseRegion(
            //         cursor: SystemMouseCursors.click,
            //         child: Tooltip(
            //             message: person.isFavorite ? 'Remover' : 'Favoritar',
            //             child: CupertinoButton(
            //                 minSize: 30,
            //                 padding: EdgeInsets.zero,
            //                 borderRadius: BorderRadius.circular(50.0),
            //                 child: Icon(
            //                     person.isFavorite
            //                         ? CupertinoIcons.heart_fill
            //                         : CupertinoIcons.heart,
            //                     size: 28),
            //                 onPressed: () => onFavoriteTap(person.id)))),
            //     SizedBox(width: 2.0)
            //   ],
            // ),
            ),
      ),
    );
  }
}
