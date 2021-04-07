import 'dart:async';
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();
final _speciesController = Modular.get<SpeciesController>();

class SpeciesRepositiry {
  Box<Specie> _speciesBox = Hive.box<Specie>(speciesBox);

  Future<List<Specie>> fecthSpecies({String? nextPage}) async {
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
}
