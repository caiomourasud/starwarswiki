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
  dynamic setRes(dynamic newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setRes');
    try {
      return super.setRes(newValue);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setSearchText');
    try {
      return super.setSearchText(newValue);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSpecieSelected(int newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setSpecieSelected');
    try {
      return super.setSpecieSelected(newValue);
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
specieSelected: ${specieSelected},
filterSpecies: ${filterSpecies}
    ''';
  }
}
