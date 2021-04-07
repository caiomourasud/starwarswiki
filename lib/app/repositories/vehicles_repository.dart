import 'dart:async';
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();
final _vehiclesController = Modular.get<VehiclesController>();

class VehiclesRepositiry {
  Box<Vehicle> _vehiclesBox = Hive.box<Vehicle>(vehiclesBox);

  Future<List<Vehicle>> fecthVehicles({String? nextPage}) async {
    List<Vehicle> _vehicles = [];
    bool charge = true;
    String _url = 'https://swapi.dev/api/vehicles/?page=';

    if (nextPage != null) {
      _url = nextPage;
    } else {
      _vehicles.clear();
    }

    while (charge) {
      var res = await http.get(Uri.parse(_url));
      var json = jsonDecode(res.body);
      List list = json['results'];

      if (json['next'] != null) {
        _url = json['next'].replaceAll('http', 'https');
        _prefs.setString('next_vehicles', _url);
      } else {
        _prefs.setString('next_vehicles', '');
      }

      _vehicles = _vehiclesBox.values.toList();

      for (var json in list) {
        final vehicle = Vehicle.fromJson(json);
        _vehicles.add(vehicle);
        _vehiclesBox.add(vehicle);
      }
      if (json['next'] == null) {
        charge = false;
      }
      print(_vehicles.length);
      print(_url);
    }
    return _vehicles;
  }

  getById(int id) {
    if (id == 0) {
      return null;
    } else {
      var vehicles =
          _vehiclesController.vehicles.where((vehicle) => vehicle.id == id);
      return vehicles.first;
    }
  }
}
