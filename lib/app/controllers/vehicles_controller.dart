import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/utils/api.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/config.dart';

part 'vehicles_controller.g.dart';

StorageUtil _prefs = StorageUtil();

final _appController = Modular.get<AppController>();

class VehiclesController = _VehiclesControllerBase with _$VehiclesController;

abstract class _VehiclesControllerBase with Store {
  @observable
  Box<Vehicle> _vehiclesBox = Hive.box<Vehicle>(vehiclesBox);

  @observable
  List<Vehicle> vehicles = [];

  @action
  vehiclesFromDB() {
    vehicles = _vehiclesBox.values.toList();
  }

  @action
  addListVehicles(newValue) => vehicles.add(newValue);

  @action
  addVehiclesBox(newValue) => _vehiclesBox.add(newValue);

  @action
  clearListVehicles() => vehicles.clear();

  @action
  clearVehiclesBox() => _vehiclesBox.clear();

  @action
  deleteVehiclesBox() => _vehiclesBox.deleteFromDisk();

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
  double searchSize = 0.0;

  @action
  setSearchSize(newValue) => searchSize = newValue;

  @action
  vehicleById(int id) {
    if (id == 0) {
      return null;
    } else {
      var vehicle = vehicles.where((vehicle) => vehicle.id == id);
      return vehicle.first;
    }
  }

  @observable
  int vehicleSelected = 0;

  @action
  setVehicleSelected(int newValue) {
    vehicleSelected = newValue;
  }

  API? api;

  @action
  getVehicles() async {
    clearVehiclesBox();
    clearListVehicles();
    setVehicleSelected(0);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi('https://swapi.dev/api/vehicles/', successGetVehicles, error,
        _appController.context!);
  }

  @action
  getMoreVehicles(String link) async {
    setRes(false);
    if (api != null) api!.cancel();
    api = API();
    api!.getApi(link, successGetMoreVehicles, error, _appController.context!);
  }

  successGetVehicles(jsonData) async {
    if (jsonData != null) {
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_vehicles', next);
      }
      Iterable vehicles = jsonData['results'];
      vehicles.map((vehicle) {
        addListVehicles(Vehicle.fromJson(vehicle));
        addVehiclesBox(Vehicle.fromJson(vehicle));
      }).toList();
      print(next);
      setRes(true);
      if (res && jsonData['next'] != null) {
        Timer(Duration(milliseconds: 200), () {
          if (res) getMoreVehicles(next);
        });
      }
    }
  }

  successGetMoreVehicles(jsonData) async {
    if (jsonData != null) {
      Iterable vehicles = jsonData['results'];
      vehicles.map((vehicle) {
        addListVehicles(Vehicle.fromJson(vehicle));
        addVehiclesBox(Vehicle.fromJson(vehicle));
      }).toList();
      setRes(true);
      if (jsonData['next'] != null) {
        next = jsonData['next'].replaceAll('http', 'https');
        _prefs.setString('next_vehicles', next);
      } else {
        _prefs.setString('next_vehicles', '');
        next = '';
      }
      print(next);
      if (next != '' && res) getMoreVehicles(next);
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
  List<Vehicle> get filterVehicles {
    if (searchText == '') {
      return vehicles;
    } else {
      return vehicles
          .where((vehicle) => Converters()
              .simplifyString(vehicle.name)
              .contains(Converters().simplifyString(searchText)))
          .toList();
    }
  }
}
