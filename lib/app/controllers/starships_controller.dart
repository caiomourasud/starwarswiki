import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

part 'starships_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class StarshipsController = _StarshipsControllerBase with _$StarshipsController;

abstract class _StarshipsControllerBase with Store {
  @observable
  ScrollController scrollController = ScrollController();

  @observable
  Box<Starship> _starshipsBox = Hive.box<Starship>(starshipsBox);

  @observable
  List<Starship> starships = [];

  @action
  starshipsFromDB() {
    starships = _starshipsBox.values.toList();
  }

  @action
  addListStarships(newValue) => starships.add(newValue);

  @action
  addStarshipsBox(newValue) => _starshipsBox.add(newValue);

  @action
  clearListStarships() => starships.clear();

  @action
  clearStarshipsBox() => _starshipsBox.clear();

  @action
  deleteStarshipsBox() => _starshipsBox.deleteFromDisk();

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

  @observable
  Starship starshipSelected = Starship(
      cargoCapacity: '',
      consumables: '',
      costInCredits: '',
      created: '',
      crew: '',
      edited: '',
      hyperdriveRating: '',
      films: [],
      id: 0,
      length: '',
      manufacturer: '',
      mGLT: '',
      maxAtmospheringSpeed: '',
      model: '',
      name: '',
      passengers: '',
      pilots: [],
      starshipClass: '',
      url: '');

  @action
  setStarshipSelected(newValue) {
    if (newValue != null) {
      starshipSelected = newValue;
    } else {
      starshipSelected = Starship(
          cargoCapacity: '',
          consumables: '',
          costInCredits: '',
          created: '',
          crew: '',
          edited: '',
          hyperdriveRating: '',
          films: [],
          id: 0,
          length: '',
          manufacturer: '',
          mGLT: '',
          maxAtmospheringSpeed: '',
          model: '',
          name: '',
          passengers: '',
          pilots: [],
          starshipClass: '',
          url: '');
    }
  }

  API? api;

  @action
  getStarships() async {
    clearStarshipsBox();
    clearListStarships();
    setStarshipSelected(null);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi('https://swapi.dev/api/starships/', successGetStarships, error,
        _appController.context!);
  }

  @action
  getMoreStarships(String link) async {
    setRes(false);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi(link, successGetMoreStarships, error, _appController.context!);
  }

  successGetStarships(jsonData) async {
    if (jsonData != null) {
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_starships', next);
      }
      Iterable starships = jsonData['results'];
      starships.map((starship) {
        addListStarships(Starship.fromJson(starship));
        addStarshipsBox(Starship.fromJson(starship));
      }).toList();
      print(next);
      setRes(true);
      if (res && jsonData['next'] != null) {
        Timer(Duration(milliseconds: 200), () {
          if (res) getMoreStarships(next);
        });
      }
    }
  }

  successGetMoreStarships(jsonData) async {
    if (jsonData != null) {
      Iterable starships = jsonData['results'];
      starships.map((starship) {
        addListStarships(Starship.fromJson(starship));
        addStarshipsBox(Starship.fromJson(starship));
      }).toList();
      setRes(true);
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_starships', next);
      } else {
        _prefs.setString('next_starships', '');
        next = '';
      }
      print(next);
      if (next != '' && res) getMoreStarships(next);
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
  List<Starship> get filterStarships {
    if (searchText == '') {
      return starships;
    } else {
      return starships
          .where((starship) => starship.name
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
