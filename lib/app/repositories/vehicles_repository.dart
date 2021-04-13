import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:starwarswiki/app/components/snack_bar_widget.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();
final _vehiclesController = Modular.get<VehiclesController>();

class VehiclesRepositiry {
  Box<Vehicle> _vehiclesBox = Hive.box<Vehicle>(vehiclesBox);

  Future<List<Vehicle>> fecthVehicles({String? nextPage}) async {
    if (_appController.noInternet)
      SnackBarWidget()
          .show(context: _appController.context!, mensagem: 'No internet.');

    List<Vehicle> _vehicles = [];
    bool charge = true;
    String _url = 'https://swapi.dev/api/vehicles/?page=';

    if (nextPage != null) {
      _url = nextPage;
    } else {
      _vehiclesBox.clear();
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

  setFavorite({required BuildContext context, required int id}) {
    var foundIndex =
        _vehiclesController.vehicles.indexWhere((vehicle) => vehicle.id == id);
    _vehiclesController.vehicles[foundIndex].isFavorite =
        !_vehiclesController.vehicles[foundIndex].isFavorite;
    _vehiclesBox.putAt(foundIndex, _vehiclesController.vehicles[foundIndex]);
    _vehiclesController.vehicles = _vehiclesBox.values.toList();
    SnackBarWidget().show(
        context: context,
        mensagem:
            '${_vehiclesController.vehicles[foundIndex].name} has been ${_vehiclesController.vehicles[foundIndex].isFavorite ? 'added to' : 'removed from'} the favorites list',
        action: 'Undo',
        onPressed: () => setFavorite(context: context, id: id));
  }
}
