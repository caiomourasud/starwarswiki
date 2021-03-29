import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/app_controller.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';
part 'planets_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class PlanetsController = _PlanetsControllerBase with _$PlanetsController;

abstract class _PlanetsControllerBase with Store {
  @observable
  ScrollController scrollController = ScrollController();

  @observable
  Box<Planet> _planetsBox = Hive.box<Planet>(planetsBox);

  @observable
  List<Planet> planets = [];

  @action
  planetsFromDB() {
    planets = _planetsBox.values.toList();
  }

  @action
  addListPlanets(newValue) => planets.add(newValue);

  @action
  addPlanetsBox(newValue) => _planetsBox.add(newValue);

  @action
  clearListPlanets() => planets.clear();

  @action
  clearPlanetsBox() => _planetsBox.clear();

  @action
  deletePlanetsBox() => _planetsBox.deleteFromDisk();

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
  double scrollPosition = 0.0;

  @action
  setScrollPosition(newValue) => scrollPosition = newValue;

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

  @action
  setFavorite(int id) {
    var foundIndex = planets.indexWhere((planet) => planet.id == id);
    // films[foundIndex].isFavorite = !films[foundIndex].isFavorite;
    _planetsBox.putAt(foundIndex, planets[foundIndex]);
  }

  @observable
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @observable
  Planet planetSelected = Planet(
      climate: '',
      created: '',
      diameter: '',
      edited: '',
      films: [],
      gravity: '',
      id: 0,
      name: '',
      orbitalPeriod: '',
      population: '',
      residents: [],
      rotationPeriod: '',
      surfaceWater: '',
      terrain: '',
      url: '');

  @action
  setPlanetSelected(newValue) {
    if (newValue != null) {
      planetSelected = newValue;
    } else {
      planetSelected = Planet(
          climate: '',
          created: '',
          diameter: '',
          edited: '',
          films: [],
          gravity: '',
          id: 0,
          name: '',
          orbitalPeriod: '',
          population: '',
          residents: [],
          rotationPeriod: '',
          surfaceWater: '',
          terrain: '',
          url: '');
    }
  }

  API? api;

  @action
  getPlanets() async {
    clearPlanetsBox();
    clearListPlanets();
    setPlanetSelected(null);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi('https://swapi.dev/api/planets/', successGetPlanets, error,
        _appController.context!);
  }

  @action
  getMorePlanets(String link) async {
    setRes(false);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi(link, successGetMorePlanets, error, _appController.context!);
  }

  successGetPlanets(jsonData) async {
    if (jsonData != null) {
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_planets', next);
      }
      Iterable planets = jsonData['results'];
      planets.map((planet) {
        addListPlanets(Planet.fromJson(planet));
        addPlanetsBox(Planet.fromJson(planet));
      }).toList();
      print(next);
      setRes(true);
      if (res && jsonData['next'] != null) {
        Timer(Duration(milliseconds: 200), () {
          if (res) getMorePlanets(next);
        });
      }
    }
  }

  successGetMorePlanets(jsonData) async {
    if (jsonData != null) {
      Iterable planets = jsonData['results'];
      planets.map((planet) {
        addListPlanets(Planet.fromJson(planet));
        addPlanetsBox(Planet.fromJson(planet));
      }).toList();
      setRes(true);
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_planets', next);
      } else {
        _prefs.setString('next_planets', '');
        next = '';
      }
      print(next);
      if (next != '' && res) getMorePlanets(next);
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
  List<Planet> get filterPlanets {
    if (showFavorites) {
      var favorites = planets;
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((planet) => planet.name
                .toLowerCase()
                .replaceAll('á', 'a')
                .replaceAll('é', 'e')
                .replaceAll('í', 'i')
                .replaceAll('ó', 'o')
                .replaceAll('ú', 'u')
                .replaceAll('ê', 'e')
                .replaceAll('ã', 'a')
                .replaceAll('õ', 'o')
                .replaceAll('ç', 'c')
                .contains(searchText
                    .toLowerCase()
                    .replaceAll('á', 'a')
                    .replaceAll('é', 'e')
                    .replaceAll('í', 'i')
                    .replaceAll('ó', 'o')
                    .replaceAll('ú', 'u')
                    .replaceAll('ê', 'e')
                    .replaceAll('ã', 'a')
                    .replaceAll('õ', 'o')
                    .replaceAll('ç', 'c')))
            .toList();
      }
    } else {
      if (searchText == '') {
        return planets;
      } else {
        return planets
            .where((planet) => planet.name
                .toLowerCase()
                .replaceAll('á', 'a')
                .replaceAll('é', 'e')
                .replaceAll('í', 'i')
                .replaceAll('ó', 'o')
                .replaceAll('ú', 'u')
                .replaceAll('ê', 'e')
                .replaceAll('ã', 'a')
                .replaceAll('õ', 'o')
                .replaceAll('ç', 'c')
                .contains(searchText
                    .toLowerCase()
                    .replaceAll('á', 'a')
                    .replaceAll('é', 'e')
                    .replaceAll('í', 'i')
                    .replaceAll('ó', 'o')
                    .replaceAll('ú', 'u')
                    .replaceAll('ê', 'e')
                    .replaceAll('ã', 'a')
                    .replaceAll('õ', 'o')
                    .replaceAll('ç', 'c')))
            .toList();
      }
    }
  }
}
