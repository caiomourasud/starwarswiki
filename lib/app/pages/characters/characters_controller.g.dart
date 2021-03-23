// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CharactersController on _CharactersControllerBase, Store {
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

  final _$positionAtom = Atom(name: '_CharactersControllerBase.position');

  @override
  double get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(double value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
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
  PeopleTable get personSelected {
    _$personSelectedAtom.reportRead();
    return super.personSelected;
  }

  @override
  set personSelected(PeopleTable value) {
    _$personSelectedAtom.reportWrite(value, super.personSelected, () {
      super.personSelected = value;
    });
  }

  @override
  String toString() {
    return '''
res: ${res},
next: ${next},
position: ${position},
showFavorites: ${showFavorites},
searchSize: ${searchSize},
personSelected: ${personSelected}
    ''';
  }
}
