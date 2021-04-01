import 'dart:async';
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/controllers/planets_controller.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();
final _planetsController = Modular.get<PlanetsController>();

class PlanetsRepositiry {
  Box<Planet> _planetsBox = Hive.box<Planet>(planetsBox);

  Future<List<Planet>> fecthPlanets({String? nextPage}) async {
    List<Planet> _planets = [];
    bool charge = true;
    String _url = 'https://swapi.dev/api/planets/?page=';

    if (nextPage != null) {
      _url = nextPage;
    } else {
      _planets.clear();
    }

    while (charge) {
      var res = await http.get(Uri.parse(_url));
      var json = jsonDecode(res.body);
      List list = json['results'];

      if (json['next'] != null) {
        _url = json['next'].replaceAll('http', 'https');
        _prefs.setString('next_planets', _url);
      } else {
        _prefs.setString('next_planets', '');
      }

      _planets = _planetsBox.values.toList();

      for (var json in list) {
        final planet = Planet.fromJson(json);
        _planets.add(planet);
        _planetsBox.add(planet);
      }
      if (json['next'] == null) {
        charge = false;
      }
      print(_planets.length);
      print(_url);
    }
    return _planets;
  }

  getById(int id) {
    if (id == 0) {
      return null;
    } else {
      var planets =
          _planetsController.planets.where((planet) => planet.id == id);
      return planets.first;
    }
  }
}
