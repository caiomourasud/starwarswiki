import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/database/film.dart';
import 'package:starwarswiki/app/models/database/people.dart';
import 'package:starwarswiki/app/models/database/planet.dart';
import 'package:starwarswiki/app/models/database/specie.dart';
import 'package:starwarswiki/app/models/database/starship.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/repositories/films_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

import 'characters_controller.dart';
import 'planets_controller.dart';
import 'species_controller.dart';
import 'starships_controller.dart';
import 'vehicles_controller.dart';

part 'films_controller.g.dart';

final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

final _filmsRepository = FilmsRepositiry();

class FilmsController = _FilmsControllerBase with _$FilmsController;

abstract class _FilmsControllerBase with Store {
  @observable
  Box<Film> _filmsBox = Hive.box<Film>(filmsBox);

  @observable
  List<Film> films = [];

  @action
  getFilms({String? nextPage}) async {
    setRes(false);
    if (_filmsBox.values.isNotEmpty && nextPage == null) {
      films = _filmsBox.values.toList();
      setRes(true);
    } else {
      films = [];
      films = await _filmsRepository.fecthFilms(nextPage: nextPage);
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
  int filmSelected = 0;

  @action
  setFilmSelected(int value) {
    filmSelected = value;
  }

  @computed
  List<Film> get filterFilms {
    if (showFavorites) {
      var favorites = films.where((film) => film.isFavorite).toList();
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((film) => Converters()
                .simplifyString(film.title)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    } else {
      if (searchText == '') {
        return films;
      } else {
        return films
            .where((film) => Converters()
                .simplifyString(film.title)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    }
  }

  @observable
  List<People> characters = [];
  @observable
  List<Planet> planets = [];
  @observable
  List<Starship> starships = [];
  @observable
  List<Vehicle> vehicles = [];
  @observable
  List<Specie> species = [];

  @action
  clearAll() {
    characters.clear();
    planets.clear();
    starships.clear();
    vehicles.clear();
    species.clear();
  }

  @action
  setList(widget) {
    clearAll();
    for (var person in widget.film.characters) {
      characters.addAll(_charactersController.people
          .where((character) => person == character.url));
    }
    for (var planet in widget.film.planets) {
      planets
          .addAll(_planetsController.planets.where((pl) => planet == pl.url));
    }
    for (var specie in widget.film.species) {
      species
          .addAll(_speciesController.species.where((sp) => specie == sp.url));
    }
    for (var starship in widget.film.starships) {
      starships.addAll(
          _starshipsController.starships.where((st) => starship == st.url));
    }
    for (var vehicle in widget.film.vehicles) {
      vehicles.addAll(
          _vehiclesController.vehicles.where((ve) => vehicle == ve.url));
    }
  }
}
