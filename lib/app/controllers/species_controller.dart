import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/repositories/species_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

import 'characters_controller.dart';
import 'films_controller.dart';
part 'species_controller.g.dart';

final _charactersController = Modular.get<CharactersController>();
final _filmsController = Modular.get<FilmsController>();

final _speciesRepository = SpeciesRepositiry();

class SpeciesController = _SpeciesControllerBase with _$SpeciesController;

abstract class _SpeciesControllerBase with Store {
  @observable
  Box<Specie> _speciesBox = Hive.box<Specie>(speciesBox);

  @observable
  List<Specie> species = [];

  @action
  getSpecies({String? nextPage}) async {
    setRes(false);
    if (_speciesBox.values.isNotEmpty && nextPage == null) {
      species = _speciesBox.values.toList();
      setRes(true);
    } else {
      species = [];
      species = await _speciesRepository.fecthSpecies(nextPage: nextPage);
      setRes(true);
    }
  }

  @observable
  bool res = true;

  @action
  setRes(newValue) => res = newValue;

  @observable
  String searchText = '';

  @action
  setSearchText(newValue) => searchText = newValue;

  @observable
  int specieSelected = 0;

  @action
  setSpecieSelected(int newValue) {
    specieSelected = newValue;
  }

  @computed
  List<Specie> get filterSpecies {
    if (searchText == '') {
      return species;
    } else {
      return species
          .where((specie) => Converters()
              .simplifyString(specie.name)
              .contains(Converters().simplifyString(searchText)))
          .toList();
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

    for (var person in widget.specie.people) {
      characters.addAll(_charactersController.people
          .where((character) => person == character.url));
    }
    for (var film in widget.specie.films) {
      films.addAll(_filmsController.films.where((pl) => film == pl.url));
    }
  }
}
