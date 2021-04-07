import 'dart:async';
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/controllers/films_controller.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();
final _filmsController = Modular.get<FilmsController>();

class FilmsRepositiry {
  Box<Film> _filmsBox = Hive.box<Film>(filmsBox);

  Future<List<Film>> fecthFilms({String? nextPage}) async {
    List<Film> _films = [];
    bool charge = true;
    String _url = 'https://swapi.dev/api/films/?page=';

    if (nextPage != null) {
      _url = nextPage;
    } else {
      _filmsBox.clear();
    }

    while (charge) {
      var res = await http.get(Uri.parse(_url));
      var json = jsonDecode(res.body);
      List list = json['results'];

      if (json['next'] != null) {
        _url = json['next'].replaceAll('http', 'https');
        _prefs.setString('next_films', _url);
      } else {
        _prefs.setString('next_films', '');
      }

      _films = _filmsBox.values.toList();

      for (var json in list) {
        final film = Film.fromJson(json);
        _films.add(film);
        _filmsBox.add(film);
      }
      if (json['next'] == null) {
        charge = false;
      }
      print(_films.length);
      print(_url);
    }
    return _films;
  }

  getById(int id) {
    if (id == 0) {
      return null;
    } else {
      var films = _filmsController.films.where((films) => films.id == id);
      return films.first;
    }
  }
}
