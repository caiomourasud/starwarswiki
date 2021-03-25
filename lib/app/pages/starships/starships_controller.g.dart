// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'starships_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StarshipsController on _StarshipsControllerBase, Store {
  Computed<List<Starship>>? _$filterStarshipsComputed;

  @override
  List<Starship> get filterStarships => (_$filterStarshipsComputed ??=
          Computed<List<Starship>>(() => super.filterStarships,
              name: '_StarshipsControllerBase.filterStarships'))
      .value;

  final _$scrollControllerAtom =
      Atom(name: '_StarshipsControllerBase.scrollController');

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

  final _$_starshipsBoxAtom =
      Atom(name: '_StarshipsControllerBase._starshipsBox');

  @override
  Box<Starship> get _starshipsBox {
    _$_starshipsBoxAtom.reportRead();
    return super._starshipsBox;
  }

  @override
  set _starshipsBox(Box<Starship> value) {
    _$_starshipsBoxAtom.reportWrite(value, super._starshipsBox, () {
      super._starshipsBox = value;
    });
  }

  final _$starshipsAtom = Atom(name: '_StarshipsControllerBase.starships');

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

  final _$resAtom = Atom(name: '_StarshipsControllerBase.res');

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

  final _$searchTextAtom = Atom(name: '_StarshipsControllerBase.searchText');

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

  final _$nextAtom = Atom(name: '_StarshipsControllerBase.next');

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
      Atom(name: '_StarshipsControllerBase.scrollPosition');

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
      Atom(name: '_StarshipsControllerBase.showFavorites');

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

  final _$searchSizeAtom = Atom(name: '_StarshipsControllerBase.searchSize');

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

  final _$starshipSelectedAtom =
      Atom(name: '_StarshipsControllerBase.starshipSelected');

  @override
  Starship get starshipSelected {
    _$starshipSelectedAtom.reportRead();
    return super.starshipSelected;
  }

  @override
  set starshipSelected(Starship value) {
    _$starshipSelectedAtom.reportWrite(value, super.starshipSelected, () {
      super.starshipSelected = value;
    });
  }

  final _$getStarshipsAsyncAction =
      AsyncAction('_StarshipsControllerBase.getStarships');

  @override
  Future getStarships() {
    return _$getStarshipsAsyncAction.run(() => super.getStarships());
  }

  final _$getMoreStarshipsAsyncAction =
      AsyncAction('_StarshipsControllerBase.getMoreStarships');

  @override
  Future getMoreStarships(String link) {
    return _$getMoreStarshipsAsyncAction
        .run(() => super.getMoreStarships(link));
  }

  final _$_StarshipsControllerBaseActionController =
      ActionController(name: '_StarshipsControllerBase');

  @override
  dynamic starshipsFromDB() {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.starshipsFromDB');
    try {
      return super.starshipsFromDB();
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListStarships(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.addListStarships');
    try {
      return super.addListStarships(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addStarshipsBox(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.addStarshipsBox');
    try {
      return super.addStarshipsBox(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearListStarships() {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.clearListStarships');
    try {
      return super.clearListStarships();
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearStarshipsBox() {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.clearStarshipsBox');
    try {
      return super.clearStarshipsBox();
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteStarshipsBox() {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.deleteStarshipsBox');
    try {
      return super.deleteStarshipsBox();
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRes(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setRes');
    try {
      return super.setRes(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setSearchText');
    try {
      return super.setSearchText(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNext(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setNext');
    try {
      return super.setNext(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setScrollPosition(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setScrollPosition');
    try {
      return super.setScrollPosition(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFavorite(int id) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setFavorite');
    try {
      return super.setFavorite(id);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSize(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setSearchSize');
    try {
      return super.setSearchSize(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setStarshipSelected(dynamic newValue) {
    final _$actionInfo = _$_StarshipsControllerBaseActionController.startAction(
        name: '_StarshipsControllerBase.setStarshipSelected');
    try {
      return super.setStarshipSelected(newValue);
    } finally {
      _$_StarshipsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
starships: ${starships},
res: ${res},
searchText: ${searchText},
next: ${next},
scrollPosition: ${scrollPosition},
showFavorites: ${showFavorites},
searchSize: ${searchSize},
starshipSelected: ${starshipSelected},
filterStarships: ${filterStarships}
    ''';
  }
}
