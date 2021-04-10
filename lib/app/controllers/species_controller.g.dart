// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SpeciesController on _SpeciesControllerBase, Store {
  Computed<List<Specie>>? _$filterSpeciesComputed;

  @override
  List<Specie> get filterSpecies => (_$filterSpeciesComputed ??=
          Computed<List<Specie>>(() => super.filterSpecies,
              name: '_SpeciesControllerBase.filterSpecies'))
      .value;

  final _$_speciesBoxAtom = Atom(name: '_SpeciesControllerBase._speciesBox');

  @override
  Box<Specie> get _speciesBox {
    _$_speciesBoxAtom.reportRead();
    return super._speciesBox;
  }

  @override
  set _speciesBox(Box<Specie> value) {
    _$_speciesBoxAtom.reportWrite(value, super._speciesBox, () {
      super._speciesBox = value;
    });
  }

  final _$speciesAtom = Atom(name: '_SpeciesControllerBase.species');

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

  final _$resAtom = Atom(name: '_SpeciesControllerBase.res');

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

  final _$searchTextAtom = Atom(name: '_SpeciesControllerBase.searchText');

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
      Atom(name: '_SpeciesControllerBase.showFavorites');

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

  final _$specieSelectedAtom =
      Atom(name: '_SpeciesControllerBase.specieSelected');

  @override
  int get specieSelected {
    _$specieSelectedAtom.reportRead();
    return super.specieSelected;
  }

  @override
  set specieSelected(int value) {
    _$specieSelectedAtom.reportWrite(value, super.specieSelected, () {
      super.specieSelected = value;
    });
  }

  final _$charactersAtom = Atom(name: '_SpeciesControllerBase.characters');

  @override
  List<People> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(List<People> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  final _$filmsAtom = Atom(name: '_SpeciesControllerBase.films');

  @override
  List<Film> get films {
    _$filmsAtom.reportRead();
    return super.films;
  }

  @override
  set films(List<Film> value) {
    _$filmsAtom.reportWrite(value, super.films, () {
      super.films = value;
    });
  }

  final _$getSpeciesAsyncAction =
      AsyncAction('_SpeciesControllerBase.getSpecies');

  @override
  Future getSpecies({String? nextPage}) {
    return _$getSpeciesAsyncAction
        .run(() => super.getSpecies(nextPage: nextPage));
  }

  final _$_SpeciesControllerBaseActionController =
      ActionController(name: '_SpeciesControllerBase');

  @override
  dynamic setRes(dynamic value) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setRes');
    try {
      return super.setRes(value);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic value) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setSearchText');
    try {
      return super.setSearchText(value);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic value) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(value);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSpecieSelected(int value) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setSpecieSelected');
    try {
      return super.setSpecieSelected(value);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearAll() {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.clearAll');
    try {
      return super.clearAll();
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setList(dynamic widget) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setList');
    try {
      return super.setList(widget);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
species: ${species},
res: ${res},
searchText: ${searchText},
showFavorites: ${showFavorites},
specieSelected: ${specieSelected},
characters: ${characters},
films: ${films},
filterSpecies: ${filterSpecies}
    ''';
  }
}
