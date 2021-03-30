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

  final _$scrollControllerAtom =
      Atom(name: '_SpeciesControllerBase.scrollController');

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

  final _$nextAtom = Atom(name: '_SpeciesControllerBase.next');

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

  final _$searchSizeAtom = Atom(name: '_SpeciesControllerBase.searchSize');

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

  final _$specieSelectedAtom =
      Atom(name: '_SpeciesControllerBase.specieSelected');

  @override
  Specie get specieSelected {
    _$specieSelectedAtom.reportRead();
    return super.specieSelected;
  }

  @override
  set specieSelected(Specie value) {
    _$specieSelectedAtom.reportWrite(value, super.specieSelected, () {
      super.specieSelected = value;
    });
  }

  final _$getSpeciesAsyncAction =
      AsyncAction('_SpeciesControllerBase.getSpecies');

  @override
  Future getSpecies() {
    return _$getSpeciesAsyncAction.run(() => super.getSpecies());
  }

  final _$getMoreSpeciesAsyncAction =
      AsyncAction('_SpeciesControllerBase.getMoreSpecies');

  @override
  Future getMoreSpecies(String link) {
    return _$getMoreSpeciesAsyncAction.run(() => super.getMoreSpecies(link));
  }

  final _$_SpeciesControllerBaseActionController =
      ActionController(name: '_SpeciesControllerBase');

  @override
  dynamic speciesFromDB() {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.speciesFromDB');
    try {
      return super.speciesFromDB();
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListSpecies(dynamic newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.addListSpecies');
    try {
      return super.addListSpecies(newValue);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addSpeciesBox(dynamic newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.addSpeciesBox');
    try {
      return super.addSpeciesBox(newValue);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearListSpecies() {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.clearListSpecies');
    try {
      return super.clearListSpecies();
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearSpeciesBox() {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.clearSpeciesBox');
    try {
      return super.clearSpeciesBox();
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteSpeciesBox() {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.deleteSpeciesBox');
    try {
      return super.deleteSpeciesBox();
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic setNext(dynamic newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setNext');
    try {
      return super.setNext(newValue);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSize(dynamic newValue) {
    final _$actionInfo = _$_SpeciesControllerBaseActionController.startAction(
        name: '_SpeciesControllerBase.setSearchSize');
    try {
      return super.setSearchSize(newValue);
    } finally {
      _$_SpeciesControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSpecieSelected(dynamic newValue) {
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
scrollController: ${scrollController},
species: ${species},
res: ${res},
searchText: ${searchText},
next: ${next},
searchSize: ${searchSize},
specieSelected: ${specieSelected},
filterSpecies: ${filterSpecies}
    ''';
  }
}
