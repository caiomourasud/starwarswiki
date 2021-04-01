import 'dart:async';

import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/repository/vehicles_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/code/config.dart';

part 'vehicles_controller.g.dart';

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
  setRes(newValue) => res = newValue;

  @observable
  String searchText = '';

  @action
  setSearchText(newValue) => searchText = newValue;

  @observable
  int vehicleSelected = 0;

  @action
  setVehicleSelected(int newValue) {
    vehicleSelected = newValue;
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
