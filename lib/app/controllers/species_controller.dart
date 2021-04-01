import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';
part 'species_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class SpeciesController = _SpeciesControllerBase with _$SpeciesController;

abstract class _SpeciesControllerBase with Store {
  @observable
  Box<Specie> _speciesBox = Hive.box<Specie>(speciesBox);

  @observable
  List<Specie> species = [];

  @action
  speciesFromDB() {
    species = _speciesBox.values.toList();
  }

  @action
  addListSpecies(newValue) => species.add(newValue);

  @action
  addSpeciesBox(newValue) => _speciesBox.add(newValue);

  @action
  clearListSpecies() => species.clear();

  @action
  clearSpeciesBox() => _speciesBox.clear();

  @action
  deleteSpeciesBox() => _speciesBox.deleteFromDisk();

  @observable
  bool res = true;

  @action
  setRes(newValue) => res = newValue;

  @observable
  String searchText = '';

  @action
  setSearchText(newValue) => searchText = newValue;

  @observable
  String next = '';

  @action
  setNext(newValue) => next = newValue;

  @observable
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @action
  specieById(int id) {
    if (id == 0) {
      return null;
    } else {
      var specie = species.where((specie) => specie.id == id);
      return specie.first;
    }
  }

  @observable
  int specieSelected = 0;

  @action
  setSpecieSelected(int newValue) {
    specieSelected = newValue;
  }

  API? api;

  @action
  getSpecies() async {
    clearSpeciesBox();
    clearListSpecies();
    setSpecieSelected(0);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi('https://swapi.dev/api/species/', successGetSpecies, error,
        _appController.context!);
  }

  @action
  getMoreSpecies(String link) async {
    setRes(false);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi(link, successGetMoreSpecies, error, _appController.context!);
  }

  successGetSpecies(jsonData) async {
    if (jsonData != null) {
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_species', next);
      }
      Iterable species = jsonData['results'];
      species.map((specie) {
        addListSpecies(Specie.fromJson(specie));
        addSpeciesBox(Specie.fromJson(specie));
      }).toList();
      print(next);
      setRes(true);
      if (res && jsonData['next'] != null) {
        Timer(Duration(milliseconds: 200), () {
          if (res) getMoreSpecies(next);
        });
      }
    }
  }

  successGetMoreSpecies(jsonData) async {
    if (jsonData != null) {
      Iterable species = jsonData['results'];
      species.map((specie) {
        addListSpecies(Specie.fromJson(specie));
        addSpeciesBox(Specie.fromJson(specie));
      }).toList();
      setRes(true);
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_species', next);
      } else {
        _prefs.setString('next_species', '');
        next = '';
      }
      print(next);
      if (next != '' && res) getMoreSpecies(next);
    }
  }

  error(jsonData) {
    setRes(true);
    if (jsonData != null) {
      print('error');
      // alert.alertDialog(
      //     context: context,
      //     titulo: 'Atenção',
      //     subtitulo: jsonData,
      //     secundario: 'OK',
      //     cor: Colors.red);
    }
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
}