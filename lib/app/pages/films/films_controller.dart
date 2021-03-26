import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/app_controller.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

part 'films_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class FilmsController = _FilmsControllerBase with _$FilmsController;

abstract class _FilmsControllerBase with Store {
  @observable
  ScrollController scrollController = ScrollController();

  @observable
  Box<Film> _filmsBox = Hive.box<Film>(filmsBox);

  @observable
  List<Film> films = [];

  @action
  filmsFromDB() {
    films = _filmsBox.values.toList()
      ..sort((a, b) => a.episodeId.compareTo(b.episodeId));
    // someObjects.sort((a, b) => a.someProperty.compareTo(b.someProperty));
  }

  @action
  addListFilms(newValue) => films.add(newValue);

  @action
  addFilmsBox(newValue) => _filmsBox.add(newValue);

  @action
  clearListFilms() => films.clear();

  @action
  clearFilmsBox() => _filmsBox.clear();

  @action
  deleteFilmsBox() => _filmsBox.deleteFromDisk();

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
    var foundIndex = films.indexWhere((film) => film.id == id);
    // films[foundIndex].isFavorite = !films[foundIndex].isFavorite;
    _filmsBox.putAt(foundIndex, films[foundIndex]);
  }

  @observable
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @observable
  Film filmSelected = Film(
      characters: [],
      created: '',
      director: '',
      edited: '',
      episodeId: 0,
      id: 0,
      openingCrawl: '',
      planets: [],
      producer: '',
      releaseDate: '',
      species: [],
      starships: [],
      title: '',
      url: '',
      vehicles: []);

  @action
  setFilmSelected(newValue) {
    if (newValue != null) {
      filmSelected = newValue;
    } else {
      filmSelected = Film(
          characters: [],
          created: '',
          director: '',
          edited: '',
          episodeId: 0,
          id: 0,
          openingCrawl: '',
          planets: [],
          producer: '',
          releaseDate: '',
          species: [],
          starships: [],
          title: '',
          url: '',
          vehicles: []);
    }
  }

  API? api;

  @action
  getFilms() async {
    clearFilmsBox();
    clearListFilms();
    setFilmSelected(null);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi('https://swapi.dev/api/films/', successGetFilms, error,
        _appController.context!);
  }

  @action
  getMoreFilms(String link) async {
    setRes(false);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi(link, successGetMoreFilms, error, _appController.context!);
  }

  successGetFilms(jsonData) async {
    if (jsonData != null) {
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_films', next);
      }
      Iterable films = jsonData['results'];
      films.map((film) {
        addListFilms(Film.fromJson(film));
        addFilmsBox(Film.fromJson(film));
      }).toList();
      print(next);
      setRes(true);
      if (res && jsonData['next'] != null) {
        Timer(Duration(milliseconds: 200), () {
          if (res) getMoreFilms(next);
        });
      }
    }
  }

  successGetMoreFilms(jsonData) async {
    if (jsonData != null) {
      Iterable films = jsonData['results'];
      films.map((film) {
        addListFilms(Film.fromJson(film));
        addFilmsBox(Film.fromJson(film));
      }).toList();
      setRes(true);
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_films', next);
      } else {
        _prefs.setString('next_films', '');
        next = '';
      }
      print(next);
      if (next != '' && res) getMoreFilms(next);
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
  List<Film> get filterFilms {
    if (showFavorites) {
      var favorites = films;
      // films.where((personagem) => personagem.isFavorite).toList();
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((film) => film.title
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
        return films;
      } else {
        return films
            .where((film) => film.title
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
