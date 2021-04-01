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

  final _$nextAtom = Atom(name: '_CharactersControllerBase.next');

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

  final _$searchSizeAtom = Atom(name: '_CharactersControllerBase.searchSize');

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
  Future getPeople() {
    return _$getPeopleAsyncAction.run(() => super.getPeople());
  }

  final _$getMorePeopleAsyncAction =
      AsyncAction('_CharactersControllerBase.getMorePeople');

  @override
  Future getMorePeople(String link) {
    return _$getMorePeopleAsyncAction.run(() => super.getMorePeople(link));
  }

  final _$_CharactersControllerBaseActionController =
      ActionController(name: '_CharactersControllerBase');

  @override
  dynamic peopleFromDB() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.peopleFromDB');
    try {
      return super.peopleFromDB();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListPeople(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.addListPeople');
    try {
      return super.addListPeople(newValue);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addPeopleBox(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.addPeopleBox');
    try {
      return super.addPeopleBox(newValue);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearListPeople() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.clearListPeople');
    try {
      return super.clearListPeople();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearPeopleBox() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.clearPeopleBox');
    try {
      return super.clearPeopleBox();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deletePeopleBox() {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.deletePeopleBox');
    try {
      return super.deletePeopleBox();
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

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
  dynamic setNext(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setNext');
    try {
      return super.setNext(newValue);
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
  dynamic setFavorite(int id) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setFavorite');
    try {
      return super.setFavorite(id);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSize(dynamic newValue) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.setSearchSize');
    try {
      return super.setSearchSize(newValue);
    } finally {
      _$_CharactersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic personById(int id) {
    final _$actionInfo = _$_CharactersControllerBaseActionController
        .startAction(name: '_CharactersControllerBase.personById');
    try {
      return super.personById(id);
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
next: ${next},
showFavorites: ${showFavorites},
searchSize: ${searchSize},
personSelected: ${personSelected},
filterCharacters: ${filterCharacters}
    ''';
  }
}
