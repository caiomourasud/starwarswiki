// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'films_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilmsController on _FilmsControllerBase, Store {
  Computed<List<Film>>? _$filterFilmsComputed;

  @override
  List<Film> get filterFilms =>
      (_$filterFilmsComputed ??= Computed<List<Film>>(() => super.filterFilms,
              name: '_FilmsControllerBase.filterFilms'))
          .value;

  final _$scrollControllerAtom =
      Atom(name: '_FilmsControllerBase.scrollController');

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

  final _$_filmsBoxAtom = Atom(name: '_FilmsControllerBase._filmsBox');

  @override
  Box<Film> get _filmsBox {
    _$_filmsBoxAtom.reportRead();
    return super._filmsBox;
  }

  @override
  set _filmsBox(Box<Film> value) {
    _$_filmsBoxAtom.reportWrite(value, super._filmsBox, () {
      super._filmsBox = value;
    });
  }

  final _$filmsAtom = Atom(name: '_FilmsControllerBase.films');

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

  final _$resAtom = Atom(name: '_FilmsControllerBase.res');

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

  final _$searchTextAtom = Atom(name: '_FilmsControllerBase.searchText');

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

  final _$nextAtom = Atom(name: '_FilmsControllerBase.next');

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
      Atom(name: '_FilmsControllerBase.scrollPosition');

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

  final _$showFavoritesAtom = Atom(name: '_FilmsControllerBase.showFavorites');

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

  final _$searchSizeAtom = Atom(name: '_FilmsControllerBase.searchSize');

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

  final _$filmSelectedAtom = Atom(name: '_FilmsControllerBase.filmSelected');

  @override
  Film get filmSelected {
    _$filmSelectedAtom.reportRead();
    return super.filmSelected;
  }

  @override
  set filmSelected(Film value) {
    _$filmSelectedAtom.reportWrite(value, super.filmSelected, () {
      super.filmSelected = value;
    });
  }

  final _$getFilmsAsyncAction = AsyncAction('_FilmsControllerBase.getFilms');

  @override
  Future getFilms() {
    return _$getFilmsAsyncAction.run(() => super.getFilms());
  }

  final _$getMoreFilmsAsyncAction =
      AsyncAction('_FilmsControllerBase.getMoreFilms');

  @override
  Future getMoreFilms(String link) {
    return _$getMoreFilmsAsyncAction.run(() => super.getMoreFilms(link));
  }

  final _$_FilmsControllerBaseActionController =
      ActionController(name: '_FilmsControllerBase');

  @override
  dynamic filmsFromDB() {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.filmsFromDB');
    try {
      return super.filmsFromDB();
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addListFilms(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.addListFilms');
    try {
      return super.addListFilms(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addFilmsBox(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.addFilmsBox');
    try {
      return super.addFilmsBox(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearListFilms() {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.clearListFilms');
    try {
      return super.clearListFilms();
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearFilmsBox() {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.clearFilmsBox');
    try {
      return super.clearFilmsBox();
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteFilmsBox() {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.deleteFilmsBox');
    try {
      return super.deleteFilmsBox();
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRes(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setRes');
    try {
      return super.setRes(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchText(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setSearchText');
    try {
      return super.setSearchText(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNext(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setNext');
    try {
      return super.setNext(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setScrollPosition(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setScrollPosition');
    try {
      return super.setScrollPosition(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShowFavorites(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setShowFavorites');
    try {
      return super.setShowFavorites(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFavorito(int id) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setFavorito');
    try {
      return super.setFavorito(id);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSearchSize(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setSearchSize');
    try {
      return super.setSearchSize(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilmSelected(dynamic newValue) {
    final _$actionInfo = _$_FilmsControllerBaseActionController.startAction(
        name: '_FilmsControllerBase.setFilmSelected');
    try {
      return super.setFilmSelected(newValue);
    } finally {
      _$_FilmsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
films: ${films},
res: ${res},
searchText: ${searchText},
next: ${next},
scrollPosition: ${scrollPosition},
showFavorites: ${showFavorites},
searchSize: ${searchSize},
filmSelected: ${filmSelected},
filterFilms: ${filterFilms}
    ''';
  }
}
