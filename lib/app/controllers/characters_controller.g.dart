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
  dynamic setRes(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setRes');
    try {
      return super.setRes(newValue);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setSearchText');
    try {
      return super.setSearchText(newValue);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(newValue);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPersonSelected(int newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setPersonSelected');
    try {
      return super.setPersonSelected(newValue);
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
filterCharacters: ${filterCharacters}
    ''';
  }
}
