import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/repository/films_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

part 'films_controller.g.dart';

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
  setRes(newValue) => res = newValue;

  @observable
  String searchText = '';

  @action
  setSearchText(newValue) => searchText = newValue;

  @observable
  int filmSelected = 0;

  @action
  setFilmSelected(int newValue) {
    filmSelected = newValue;
  }

  @computed
  List<Film> get filterFilms {
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
