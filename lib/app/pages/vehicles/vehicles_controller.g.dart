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

  final _$scrollControllerAtom =
      Atom(name: '_VehiclesControllerBase.scrollController');

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

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

  final _$nextAtom = Atom(name: '_VehiclesControllerBase.next');

  @override
  String get next {
    _$nextAtom.reportRead();
    return super.next;
  }

  @override
  set next(String value) {
    _$nextAtom.reportWrite(value, super.next, () {
      super.next = value;
    });
  }

  final _$scrollPositionAtom =
      Atom(name: '_VehiclesControllerBase.scrollPosition');

  @override
  double get scrollPosition {
    _$scrollPositionAtom.reportRead();
    return super.scrollPosition;
  }

  @override
  set scrollPosition(double value) {
    _$scrollPositionAtom.reportWrite(value, super.scrollPosition, () {
      super.scrollPosition = value;
    });
  }

  final _$showFavoritesAtom =
      Atom(name: '_VehiclesControllerBase.showFavorites');

  @override
  bool get showFavorites {
    _$showFavoritesAtom.reportRead();
    return super.showFavorites;
  }

  @override
  set showFavorites(bool value) {
    _$showFavoritesAtom.reportWrite(value, super.showFavorites, () {
      super.showFavorites = value;
    });
  }

  final _$searchSizeAtom = Atom(name: '_VehiclesControllerBase.searchSize');

  @override
  double get searchSize {
    _$searchSizeAtom.reportRead();
    return super.searchSize;
  }

  @override
  set searchSize(double value) {
    _$searchSizeAtom.reportWrite(value, super.searchSize, () {
      super.searchSize = value;
    });
  }

  final _$vehicleSelectedAtom =
      Atom(name: '_VehiclesControllerBase.vehicleSelected');

  @override
  Vehicle get vehicleSelected {
    _$vehicleSelectedAtom.reportRead();
    return super.vehicleSelected;
  }

  @override
  set vehicleSelected(Vehicle value) {
    _$vehicleSelectedAtom.reportWrite(value, super.vehicleSelected, () {
      super.vehicleSelected = value;
    });
  }

  final _$getVehiclesAsyncAction =
      AsyncAction('_VehiclesControllerBase.getVehicles');

  @override
  Future getVehicles() {
    return _$getVehiclesAsyncAction.run(() => super.getVehicles());
  }

  final _$getMoreVehiclesAsyncAction =
      AsyncAction('_VehiclesControllerBase.getMoreVehicles');

  @override
  Future getMoreVehicles(String link) {
    return _$getMoreVehiclesAsyncAction.run(() => super.getMoreVehicles(link));
  }

  final _$_VehiclesControllerBaseActionController =
      ActionController(name: '_VehiclesControllerBase');

  @override
  dynamic vehiclesFromDB() {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.vehiclesFromDB');
    try {
      return super.vehiclesFromDB();
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListVehicles(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.addListVehicles');
    try {
      return super.addListVehicles(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addVehiclesBox(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.addVehiclesBox');
    try {
      return super.addVehiclesBox(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearListVehicles() {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.clearListVehicles');
    try {
      return super.clearListVehicles();
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearVehiclesBox() {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.clearVehiclesBox');
    try {
      return super.clearVehiclesBox();
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteVehiclesBox() {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.deleteVehiclesBox');
    try {
      return super.deleteVehiclesBox();
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic setNext(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setNext');
    try {
      return super.setNext(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setScrollPosition(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setScrollPosition');
    try {
      return super.setScrollPosition(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFavorite(int id) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setFavorite');
    try {
      return super.setFavorite(id);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSize(dynamic newValue) {
    final _$actionInfo = _$_VehiclesControllerBaseActionController.startAction(
        name: '_VehiclesControllerBase.setSearchSize');
    try {
      return super.setSearchSize(newValue);
    } finally {
      _$_VehiclesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setVehicleSelected(dynamic newValue) {
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
scrollController: ${scrollController},
vehicles: ${vehicles},
res: ${res},
searchText: ${searchText},
next: ${next},
scrollPosition: ${scrollPosition},
showFavorites: ${showFavorites},
searchSize: ${searchSize},
vehicleSelected: ${vehicleSelected},
filterVehicles: ${filterVehicles}
    ''';
  }
}
