// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  final _$scrollControllerAtom =
      Atom(name: '_SettingsControllerBase.scrollController');

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

  final _$scrollPositionAtom =
      Atom(name: '_SettingsControllerBase.scrollPosition');

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

  final _$settingSelectedAtom =
      Atom(name: '_SettingsControllerBase.settingSelected');

  @override
  int get settingSelected {
    _$settingSelectedAtom.reportRead();
    return super.settingSelected;
  }

  @override
  set settingSelected(int value) {
    _$settingSelectedAtom.reportWrite(value, super.settingSelected, () {
      super.settingSelected = value;
    });
  }

  final _$_SettingsControllerBaseActionController =
      ActionController(name: '_SettingsControllerBase');

  @override
  dynamic setScrollPosition(dynamic value) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase.setScrollPosition');
    try {
      return super.setScrollPosition(value);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSettingSelected(int value) {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase.setSettingSelected');
    try {
      return super.setSettingSelected(value);
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
scrollController: ${scrollController},
scrollPosition: ${scrollPosition},
settingSelected: ${settingSelected}
    ''';
  }
}
