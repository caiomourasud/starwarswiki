import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/database/film.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/repositories/vehicles_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

import 'films_controller.dart';

part 'vehicles_controller.g.dart';

final _filmsController = Modular.get<FilmsController>();

final _vehiclesRepository = VehiclesRepositiry();

class VehiclesController = _VehiclesControllerBase with _$VehiclesController;

abstract class _VehiclesControllerBase with Store {
  @observable
  Box<Vehicle> _vehiclesBox = Hive.box<Vehicle>(vehiclesBox);

  @observable
  List<Vehicle> vehicles = [];

  @action
  getVehicles({String? nextPage}) async {
    setRes(false);
    if (_vehiclesBox.values.isNotEmpty && nextPage == null) {
      vehicles = _vehiclesBox.values.toList();
      setRes(true);
    } else {
      vehicles = [];
      vehicles = await _vehiclesRepository.fecthVehicles(nextPage: nextPage);
      setRes(true);
    }
  }

  @observable
  bool res = true;

  @action
  setRes(value) => res = value;

  @observable
  String searchText = '';

  @action
  setSearchText(value) => searchText = value;

  @observable
  bool showFavorites = false;

  @action
  setShowFavorites(value) {
    if (value == null) {
      showFavorites = !showFavorites;
    } else {
      showFavorites = value;
    }
  }

  @observable
  int vehicleSelected = 0;

  @action
  setVehicleSelected(int value) {
    vehicleSelected = value;
  }

  @computed
  List<Vehicle> get filterVehicles {
    if (showFavorites) {
      var favorites = vehicles.where((vehicle) => vehicle.isFavorite).toList();
      if (searchText == '') {
        return favorites;
      } else {
        return favorites
            .where((vehicle) => Converters()
                .simplifyString(vehicle.name)
                .contains(Converters().simplifyString(searchText)))
            .toList();
      }
    } else {
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

  @observable
  List<Film> films = [];

  setList(widget) {
    films.clear();

    for (var starship in widget.vehicle.films) {
      films.addAll(_filmsController.films.where((st) => starship == st.url));
    }
  }
}
