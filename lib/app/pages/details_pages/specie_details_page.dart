import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';

final _charactersController = Modular.get<CharactersController>();
final _filmsController = Modular.get<FilmsController>();

List<People> characters = [];
List<Film> films = [];

bool get isAllEmpty => characters.isEmpty && films.isEmpty;

clearAll() {
  characters.clear();
  films.clear();
}

setList(widget) {
  clearAll();
  for (var specie in widget.specie.people) {
    characters.addAll(_charactersController.people
        .where((character) => specie == character.url));
  }
  for (var film in widget.specie.films) {
    films.addAll(_filmsController.films.where((pl) => film == pl.url));
  }
}

class SpecieDetailsPage extends StatefulWidget {
  final Specie? specie;
  final int backButton;

  const SpecieDetailsPage(
      {Key? key, required this.specie, required this.backButton})
      : super(key: key);
  @override
  _SpecieDetailsPageState createState() => _SpecieDetailsPageState();
}

class _SpecieDetailsPageState extends State<SpecieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    setList(widget);
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.specie!.name,
          backButton: widget.backButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              SizedBox(height: 24.0),
              if (!isAllEmpty)
                Column(
                    mainAxisSize: MainAxisSize.min,
                    children: CustomCardList()
                        .cardList(
                            context: context,
                            characters:
                                characters.isNotEmpty ? characters : null,
                            films: films.isNotEmpty ? films : null)
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
