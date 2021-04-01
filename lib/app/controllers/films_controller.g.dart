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

  final _$filmSelectedAtom = Atom(name: '_FilmsControllerBase.filmSelected');

  @override
  int get filmSelected {
    _$filmSelectedAtom.reportRead();
    return super.filmSelected;
  }

  @override
  set filmSelected(int value) {
    _$filmSelectedAtom.reportWrite(value, super.filmSelected, () {
      super.filmSelected = value;
    });
  }

  final _$getFilmsAsyncAction = AsyncAction('_FilmsControllerBase.getFilms');

  @override
  Future getFilms({String? nextPage}) {
    return _$getFilmsAsyncAction.run(() => super.getFilms(nextPage: nextPage));
  }

  final _$_FilmsControllerBaseActionController =
      ActionController(name: '_FilmsControllerBase');

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
  dynamic setFilmSelected(int newValue) {
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
films: ${films},
res: ${res},
searchText: ${searchText},
filmSelected: ${filmSelected},
filterFilms: ${filterFilms}
    ''';
  }
}
