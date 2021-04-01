import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';
part 'planets_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class PlanetsController = _PlanetsControllerBase with _$PlanetsController;

abstract class _PlanetsControllerBase with Store {
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
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @action
  planetById(int id) {
    if (id == 0) {
      return null;
    } else {
      var planet = planets.where((planet) => planet.id == id);
      return planet.first;
    }
  }

  @observable
  int planetSelected = 0;

  @action
  setPlanetSelected(int newValue) {
    planetSelected = newValue;
  }

  API? api;

  @action
  getPlanets() async {
    clearPlanetsBox();
    clearListPlanets();
    setPlanetSelected(0);
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
