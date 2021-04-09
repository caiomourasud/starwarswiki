import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/components/snack_bar_widget.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/models/database/specie.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();
final _speciesController = Modular.get<SpeciesController>();

class SpeciesRepositiry {
  Box<Specie> _speciesBox = Hive.box<Specie>(speciesBox);

  Future<List<Specie>> fecthSpecies({String? nextPage}) async {
    if (_appController.noInternet)
      SnackBarWidget()
          .show(context: _appController.context!, mensagem: 'No internet.');

    List<Specie> _species = [];
    bool charge = true;
    String _url = 'https://swapi.dev/api/species/?page=';

    if (nextPage != null) {
      _url = nextPage;
    } else {
      _species.clear();
    }

    while (charge) {
      var res = await http.get(Uri.parse(_url));
      var json = jsonDecode(res.body);
      List list = json['results'];

      if (json['next'] != null) {
        _url = json['next'].replaceAll('http', 'https');
        _prefs.setString('next_species', _url);
      } else {
        _prefs.setString('next_species', '');
      }

      _species = _speciesBox.values.toList();

      for (var json in list) {
        final specie = Specie.fromJson(json);
        _species.add(specie);
        _speciesBox.add(specie);
      }
      if (json['next'] == null) {
        charge = false;
      }
      print(_species.length);
      print(_url);
    }
    return _species;
  }

  getById(int id) {
    if (id == 0) {
      return null;
    } else {
      var species =
          _speciesController.species.where((specie) => specie.id == id);
      return species.first;
    }
  }

  setFavorite({required BuildContext context, required int id}) {
    var foundIndex =
        _speciesController.species.indexWhere((specie) => specie.id == id);
    _speciesController.species[foundIndex].isFavorite =
        !_speciesController.species[foundIndex].isFavorite;
    _speciesBox.putAt(foundIndex, _speciesController.species[foundIndex]);
    _speciesController.species = _speciesBox.values.toList();
    SnackBarWidget().show(
        context: context,
        mensagem:
            '${_speciesController.species[foundIndex].name} has been ${_speciesController.species[foundIndex].isFavorite ? 'added to' : 'removed from'} the favorites list',
        action: 'Undo',
        onPressed: () => setFavorite(context: context, id: id));
  }
}
