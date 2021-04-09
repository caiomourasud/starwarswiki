import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/database/people.dart';
import 'package:starwarswiki/app/models/database/planet.dart';
import 'package:starwarswiki/app/models/database/specie.dart';
import 'package:starwarswiki/app/models/database/starship.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/repositories/characters_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

import 'planets_controller.dart';
import 'species_controller.dart';
import 'starships_controller.dart';
import 'vehicles_controller.dart';

part 'characters_controller.g.dart';

final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

final _charactersRepository = CharactersRepositiry();

class CharactersController = _CharactersControllerBase
    with _$CharactersController;

abstract class _CharactersControllerBase with Store {
  @observable
  Box<People> _peopleBox = Hive.box<People>(peopleBox);

  @observable
  List<People> people = [];

  @action
  getPeople({String? nextPage}) async {
    setRes(false);
    if (_peopleBox.values.isNotEmpty && nextPage == null) {
      people = _peopleBox.values.toList();
      setRes(true);
    } else {
      people = [];
      people = await _charactersRepository.fecthCharacters(nextPage: nextPage);
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
  bool showFavorites = false;

  @action
  setShowFavorites(newValue) {
    if (newValue == null) {
      showFavorites = !showFavorites;
    } else {
      showFavorites = newValue;
    }
  }

  @observable
  int personSelected = 0;

  @action
  setPersonSelected(int newValue) {
    personSelected = newValue;
  }

  @computed
  List<People> get filterCharacters {
    if (showFavorites) {
      var favorites =
          people.where((personagem) => personagem.isFavorite).toList();
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((character) => Converters()
                .simplifyString(character.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    } else {
      if (searchText == '') {
        return people;
      } else {
        return people
            .where((character) => Converters()
                .simplifyString(character.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    }
  }

  @observable
  Planet? planet;

  @observable
  List<Starship> starships = [];
  @observable
  List<Vehicle> vehicles = [];
  @observable
  List<Specie> species = [];

  @action
  clearAll() {
    starships.clear();
    vehicles.clear();
    species.clear();
  }

  @action
  setList(widget) {
    clearAll();
    if (widget.character.homeworld != '') {
      List<Planet> planetTemp = _planetsController.planets
          .where((pl) => pl.url == widget.character.homeworld)
          .toList();
      planet = planetTemp[0];
    }

    if (widget.character.species.isEmpty) {
      species.addAll(_speciesController.species
          .where((sp) => sp.url == 'http://swapi.dev/api/species/1/'));
    } else {
      for (var specie in widget.character.species) {
        species
            .addAll(_speciesController.species.where((sp) => specie == sp.url));
      }
    }
    for (var starship in widget.character.starships) {
      starships.addAll(
          _starshipsController.starships.where((st) => starship == st.url));
    }
    for (var vehicle in widget.character.vehicles) {
      vehicles.addAll(
          _vehiclesController.vehicles.where((ve) => vehicle == ve.url));
    }
  }
}
