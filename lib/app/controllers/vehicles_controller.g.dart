// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VehiclesController on _VehiclesControllerBase, Store {
  Computed<List<Vehicle>>? _$filterVehiclesComputed;

  @override
  List<Vehicle> get filterVehicles => (_$filterVehiclesComputed ??=
          Computed<List<Vehicle>>(() => super.filterVehicles,
              name: '_VehiclesControllerBase.filterVehicles'))
      .value;

  final _$_vehiclesBoxAtom = Atom(name: '_VehiclesControllerBase._vehiclesBox');

  @override
  Box<Vehicle> get _vehiclesBox {
    _$_vehiclesBoxAtom.reportRead();
    return super._vehiclesBox;
  }

  @override
  set _vehiclesBox(Box<Vehicle> value) {
    _$_vehiclesBoxAtom.reportWrite(value, super._vehiclesBox, () {
      super._vehiclesBox = value;
    });
  }

  final _$vehiclesAtom = Atom(name: '_VehiclesControllerBase.vehicles');

  @override
  List<Vehicle> get vehicles {
    _$vehiclesAtom.reportRead();
    return super.vehicles;
  }

  @override
  set vehicles(List<Vehicle> value) {
    _$vehiclesAtom.reportWrite(value, super.vehicles, () {
      super.vehicles = value;
    });
  }

  final _$resAtom = Atom(name: '_VehiclesControllerBase.res');

  @override
  bool get res {
    _$resAtom.reportRead();
    return super.res;
  }

  @override
  set res(bool value) {
    _$resAtom.reportWrite(value, super.res, () {
      super.res = value;
    });
  }

  final _$searchTextAtom = Atom(name: '_VehiclesControllerBase.searchText');

  @override
  String get searchText {
    _$searchTextAtom.reportRead();
    return super.searchText;
  }

  @override
  set searchText(String value) {
    _$searchTextAtom.reportWrite(value, super.searchText, () {
      super.searchText = value;
    });
  }

  final _$vehicleSelectedAtom =
      Atom(name: '_VehiclesControllerBase.vehicleSelected');

  @override
  int get vehicleSelected {
    _$vehicleSelectedAtom.reportRead();
    return super.vehicleSelected;
  }

  @override
  set vehicleSelected(int value) {
    _$vehicleSelectedAtom.reportWrite(value, super.vehicleSelected, () {
      super.vehicleSelected = value;
    });
  }

  final _$getVehiclesAsyncAction =
      AsyncAction('_VehiclesControllerBase.getVehicles');

  @override
  Future getVehicles({String? nextPage}) {
    return _$getVehiclesAsyncAction
        .run(() => super.getVehicles(nextPage: nextPage));
  }

  final _$_VehiclesControllerBaseActionController =
      ActionController(name: '_VehiclesControllerBase');

  @override
  dynamic setRes(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setRes');
    try {
      return super.setRes(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setSearchText');
    try {
      return super.setSearchText(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setVehicleSelected(int newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setVehicleSelected');
    try {
      return super.setVehicleSelected(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
vehicles: ${vehicles},
res: ${res},
searchText: ${searchText},
vehicleSelected: ${vehicleSelected},
filterVehicles: ${filterVehicles}
    ''';
  }
}
