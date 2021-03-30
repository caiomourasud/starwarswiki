// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planets_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlanetsController on _PlanetsControllerBase, Store {
  Computed<List<Planet>>? _$filterPlanetsComputed;

  @override
  List<Planet> get filterPlanets => (_$filterPlanetsComputed ??=
          Computed<List<Planet>>(() => super.filterPlanets,
              name: '_PlanetsControllerBase.filterPlanets'))
      .value;

  final _$scrollControllerAtom =
      Atom(name: '_PlanetsControllerBase.scrollController');

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

  final _$_planetsBoxAtom = Atom(name: '_PlanetsControllerBase._planetsBox');

  @override
  Box<Planet> get _planetsBox {
    _$_planetsBoxAtom.reportRead();
    return super._planetsBox;
  }

  @override
  set _planetsBox(Box<Planet> value) {
    _$_planetsBoxAtom.reportWrite(value, super._planetsBox, () {
      super._planetsBox = value;
    });
  }

  final _$planetsAtom = Atom(name: '_PlanetsControllerBase.planets');

  @override
  List<Planet> get planets {
    _$planetsAtom.reportRead();
    return super.planets;
  }

  @override
  set planets(List<Planet> value) {
    _$planetsAtom.reportWrite(value, super.planets, () {
      super.planets = value;
    });
  }

  final _$resAtom = Atom(name: '_PlanetsControllerBase.res');

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

  final _$searchTextAtom = Atom(name: '_PlanetsControllerBase.searchText');

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

  final _$nextAtom = Atom(name: '_PlanetsControllerBase.next');

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

  final _$showFavoritesAtom =
      Atom(name: '_PlanetsControllerBase.showFavorites');

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

  final _$searchSizeAtom = Atom(name: '_PlanetsControllerBase.searchSize');

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

  final _$planetSelectedAtom =
      Atom(name: '_PlanetsControllerBase.planetSelected');

  @override
  Planet get planetSelected {
    _$planetSelectedAtom.reportRead();
    return super.planetSelected;
  }

  @override
  set planetSelected(Planet value) {
    _$planetSelectedAtom.reportWrite(value, super.planetSelected, () {
      super.planetSelected = value;
    });
  }

  final _$getPlanetsAsyncAction =
      AsyncAction('_PlanetsControllerBase.getPlanets');

  @override
  Future getPlanets() {
    return _$getPlanetsAsyncAction.run(() => super.getPlanets());
  }

  final _$getMorePlanetsAsyncAction =
      AsyncAction('_PlanetsControllerBase.getMorePlanets');

  @override
  Future getMorePlanets(String link) {
    return _$getMorePlanetsAsyncAction.run(() => super.getMorePlanets(link));
  }

  final _$_PlanetsControllerBaseActionController =
      ActionController(name: '_PlanetsControllerBase');

  @override
  dynamic planetsFromDB() {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.planetsFromDB');
    try {
      return super.planetsFromDB();
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListPlanets(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.addListPlanets');
    try {
      return super.addListPlanets(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPlanetsBox(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.addPlanetsBox');
    try {
      return super.addPlanetsBox(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearListPlanets() {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.clearListPlanets');
    try {
      return super.clearListPlanets();
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearPlanetsBox() {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.clearPlanetsBox');
    try {
      return super.clearPlanetsBox();
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deletePlanetsBox() {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.deletePlanetsBox');
    try {
      return super.deletePlanetsBox();
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRes(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.setRes');
    try {
      return super.setRes(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.setSearchText');
    try {
      return super.setSearchText(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNext(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.setNext');
    try {
      return super.setNext(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSize(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.setSearchSize');
    try {
      return super.setSearchSize(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPlanetSelected(dynamic newValue) {
    final _$actionInfo = _$_PlanetsControllerBaseActionController.startAction(
        name: '_PlanetsControllerBase.setPlanetSelected');
    try {
      return super.setPlanetSelected(newValue);
    } finally {
      _$_PlanetsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
planets: ${planets},
res: ${res},
searchText: ${searchText},
next: ${next},
showFavorites: ${showFavorites},
searchSize: ${searchSize},
planetSelected: ${planetSelected},
filterPlanets: ${filterPlanets}
    ''';
  }
}
