import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

final _charactersController = Modular.get<CharactersController>();
final _filmsController = Modular.get<FilmsController>();

List<People> characters = [];
List<Film> films = [];

class PlanetDetailsPage extends StatefulWidget {
  final Planet planet;
  final int backButton;

  const PlanetDetailsPage(
      {Key? key, required this.planet, required this.backButton})
      : super(key: key);
  @override
  _PlanetDetailsPageState createState() => _PlanetDetailsPageState();
}

setList(widget) {
  characters.clear();
  films.clear();

  for (var person in widget.planet.residents) {
    characters.addAll(_charactersController.people
        .where((character) => person == character.url));
  }
  for (var film in widget.planet.films) {
    films.addAll(_filmsController.films.where((pl) => film == pl.url));
  }
}

class _PlanetDetailsPageState extends State<PlanetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    setList(widget);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md ||
            (MediaQuery.of(context).size.width > md && widget.backButton == 2),
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        middle: Text(
          widget.planet.name,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              Container(
                height: 150.0,
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: 144.0,
                        width: 138.0,
                        decoration: BoxDecoration(
                            color: CupertinoColors.darkBackgroundGray,
                            image:
                                widget.planet.id != 28 && widget.planet.id != 46
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            ImageGenerator.generateImage(
                                                id: widget.planet.id,
                                                type: 'planets')),
                                        alignment: Alignment.topCenter,
                                        fit: BoxFit.cover)
                                    : null),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.planet.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            height: 1.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            SizedBox(height: 2.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Climate',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.planet.climate,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                SizedBox(width: 2.0),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Terrain',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.planet.terrain,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                SizedBox(width: 2.0),
                              ],
                            ),
                            SizedBox(height: 4.0)
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: CustomCardList()
                      .cardList(
                        context: context,
                        characters: characters.isNotEmpty ? characters : null,
                        charactersTitle: 'Residents',
                        charactersLines: characters.length > 6 ? 2 : 1,
                        films: films.isNotEmpty ? films : null,
                      )
                      .map((item) => CustomHorizontalList().list(
                          context: context,
                          title: item.title,
                          height: item.height *
                              (item.list.length > 3 ? item.rows : 1),
                          width: item.width *
                              (item.list.length > 3 ? item.rows : 1),
                          rows: item.list.length > 3 ? item.rows : 1,
                          viewportFraction: item.viewportFraction,
                          cards: item.list,
                          card: (index) => item.card(context, dimens, index),
                          seeAll: false,
                          onTap: () => item.onSeeAllTap(context)))
                      .toList()),
            ],
          ),
        );
      }),
    );
  }
}
