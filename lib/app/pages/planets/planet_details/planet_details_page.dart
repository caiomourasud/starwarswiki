import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
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
              SizedBox(height: 24.0),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: CustomCardList()
                      .cardList(
                        context: context,
                        characters: characters.isNotEmpty ? characters : null,
                        charactersTitle: 'Residents',
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
