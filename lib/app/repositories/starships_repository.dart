import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/components/snack_bar_widget.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/controllers/starships_controller.dart';
import 'package:starwarswiki/app/models/database/starship.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();
final _starshipsController = Modular.get<StarshipsController>();

class StarshipsRepositiry {
  Box<Starship> _starshipsBox = Hive.box<Starship>(starshipsBox);

  Future<List<Starship>> fecthStarships({String? nextPage}) async {
    if (_appController.noInternet)
      SnackBarWidget()
          .show(context: _appController.context!, mensagem: 'No internet.');

    List<Starship> _starships = [];
    bool charge = true;
    String _url = 'https://swapi.dev/api/starships/?page=';

    if (nextPage != null) {
      _url = nextPage;
    } else {
      _starshipsBox.clear();
    }

    while (charge) {
      var res = await http.get(Uri.parse(_url));
      var json = jsonDecode(res.body);
      List list = json['results'];

      if (json['next'] != null) {
        _url = json['next'].replaceAll('http', 'https');
        _prefs.setString('next_starships', _url);
      } else {
        _prefs.setString('next_starships', '');
      }

      _starships = _starshipsBox.values.toList();

      for (var json in list) {
        final starship = Starship.fromJson(json);
        _starships.add(starship);
        _starshipsBox.add(starship);
      }
      if (json['next'] == null) {
        charge = false;
      }
      print(_starships.length);
      print(_url);
    }
    return _starships;
  }

  getById(int id) {
    if (id == 0) {
      return null;
    } else {
      var starships =
          _starshipsController.starships.where((starship) => starship.id == id);
      return starships.first;
    }
  }

  setFavorite({required BuildContext context, required int id}) {
    var foundIndex = _starshipsController.starships
        .indexWhere((starship) => starship.id == id);
    _starshipsController.starships[foundIndex].isFavorite =
        !_starshipsController.starships[foundIndex].isFavorite;
    _starshipsBox.putAt(foundIndex, _starshipsController.starships[foundIndex]);
    _starshipsController.starships = _starshipsBox.values.toList();
    SnackBarWidget().show(
        context: context,
        mensagem:
            '${_starshipsController.starships[foundIndex].name} has been ${_starshipsController.starships[foundIndex].isFavorite ? 'added to' : 'removed from'} the favorites list',
        action: 'Undo',
        onPressed: () => setFavorite(context: context, id: id));
  }
}
