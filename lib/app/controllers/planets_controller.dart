import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/database/film.dart';
import 'package:starwarswiki/app/models/database/people.dart';
import 'package:starwarswiki/app/models/database/planet.dart';
import 'package:starwarswiki/app/repositories/planets_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

import 'characters_controller.dart';
import 'films_controller.dart';
part 'planets_controller.g.dart';

final _charactersController = Modular.get<CharactersController>();
final _filmsController = Modular.get<FilmsController>();

final _planetsRepository = PlanetsRepositiry();

class PlanetsController = _PlanetsControllerBase with _$PlanetsController;

abstract class _PlanetsControllerBase with Store {
  @observable
  Box<Planet> _planetsBox = Hive.box<Planet>(planetsBox);

  @observable
  List<Planet> planets = [];

  @action
  getPlanets({String? nextPage}) async {
    setRes(false);
    if (_planetsBox.values.isNotEmpty && nextPage == null) {
      planets = _planetsBox.values.toList();
      setRes(true);
    } else {
      planets = [];
      planets = await _planetsRepository.fecthPlanets(nextPage: nextPage);
      setRes(true);
    }
  }

  @observable
  bool res = true;

  @action
  setRes(value) => res = value;

  @observable
  String searchText = '';

  @action
  setSearchText(value) => searchText = value;

  @observable
  bool showFavorites = false;

  @action
  setShowFavorites(value) {
    if (value == null) {
      showFavorites = !showFavorites;
    } else {
      showFavorites = value;
    }
  }

  @observable
  int planetSelected = 0;

  @action
  setPlanetSelected(int value) {
    planetSelected = value;
  }

  @computed
  List<Planet> get filterPlanets {
    if (showFavorites) {
      var favorites = planets.where((planet) => planet.isFavorite).toList();
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((planet) => Converters()
                .simplifyString(planet.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    } else {
      if (searchText == '') {
        return planets;
      } else {
        return planets
            .where((planet) => Converters()
                .simplifyString(planet.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    }
  }

  @observable
  List<People> characters = [];
  @observable
  List<Film> films = [];

  @action
  clearAll() {
    characters.clear();
    films.clear();
  }

  @action
  setList(widget) {
    clearAll();

    for (var person in widget.planet.residents) {
      characters.addAll(_charactersController.people
          .where((character) => person == character.url));
    }
    for (var film in widget.planet.films) {
      films.addAll(_filmsController.films.where((pl) => film == pl.url));
    }
  }
}
