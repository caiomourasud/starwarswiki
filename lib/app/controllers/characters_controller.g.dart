// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharactersController on _CharactersControllerBase, Store {
  Computed<List<People>>? _$filterCharactersComputed;

  @override
  List<People> get filterCharacters => (_$filterCharactersComputed ??=
          Computed<List<People>>(() => super.filterCharacters,
              name: '_CharactersControllerBase.filterCharacters'))
      .value;

  final _$_peopleBoxAtom = Atom(name: '_CharactersControllerBase._peopleBox');

  @override
  Box<People> get _peopleBox {
    _$_peopleBoxAtom.reportRead();
    return super._peopleBox;
  }

  @override
  set _peopleBox(Box<People> value) {
    _$_peopleBoxAtom.reportWrite(value, super._peopleBox, () {
      super._peopleBox = value;
    });
  }

  final _$peopleAtom = Atom(name: '_CharactersControllerBase.people');

  @override
  List<People> get people {
    _$peopleAtom.reportRead();
    return super.people;
  }

  @override
  set people(List<People> value) {
    _$peopleAtom.reportWrite(value, super.people, () {
      super.people = value;
    });
  }

  final _$resAtom = Atom(name: '_CharactersControllerBase.res');

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

  final _$searchTextAtom = Atom(name: '_CharactersControllerBase.searchText');

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

  final _$showFavoritesAtom =
      Atom(name: '_CharactersControllerBase.showFavorites');

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

  final _$personSelectedAtom =
      Atom(name: '_CharactersControllerBase.personSelected');

  @override
  int get personSelected {
    _$personSelectedAtom.reportRead();
    return super.personSelected;
  }

  @override
  set personSelected(int value) {
    _$personSelectedAtom.reportWrite(value, super.personSelected, () {
      super.personSelected = value;
    });
  }

  final _$planetAtom = Atom(name: '_CharactersControllerBase.planet');

  @override
  Planet? get planet {
    _$planetAtom.reportRead();
    return super.planet;
  }

  @override
  set planet(Planet? value) {
    _$planetAtom.reportWrite(value, super.planet, () {
      super.planet = value;
    });
  }

  final _$starshipsAtom = Atom(name: '_CharactersControllerBase.starships');

  @override
  List<Starship> get starships {
    _$starshipsAtom.reportRead();
    return super.starships;
  }

  @override
  set starships(List<Starship> value) {
    _$starshipsAtom.reportWrite(value, super.starships, () {
      super.starships = value;
    });
  }

  final _$vehiclesAtom = Atom(name: '_CharactersControllerBase.vehicles');

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

  final _$speciesAtom = Atom(name: '_CharactersControllerBase.species');

  @override
  List<Specie> get species {
    _$speciesAtom.reportRead();
    return super.species;
  }

  @override
  set species(List<Specie> value) {
    _$speciesAtom.reportWrite(value, super.species, () {
      super.species = value;
    });
  }

  final _$getPeopleAsyncAction =
      AsyncAction('_CharactersControllerBase.getPeople');

  @override
  Future getPeople({String? nextPage}) {
    return _$getPeopleAsyncAction
        .run(() => super.getPeople(nextPage: nextPage));
  }

  final _$_CharactersControllerBaseActionController =
      ActionController(name: '_CharactersControllerBase');

  @override
  dynamic setRes(dynamic value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setRes');
    try {
      return super.setRes(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPersonSelected(int value) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setPersonSelected');
    try {
      return super.setPersonSelected(value);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearAll() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.clearAll');
    try {
      return super.clearAll();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setList(dynamic widget) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setList');
    try {
      return super.setList(widget);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
people: ${people},
res: ${res},
searchText: ${searchText},
showFavorites: ${showFavorites},
personSelected: ${personSelected},
planet: ${planet},
starships: ${starships},
vehicles: ${vehicles},
species: ${species},
filterCharacters: ${filterCharacters}
    ''';
  }
}
