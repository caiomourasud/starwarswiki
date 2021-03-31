import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'settings_controller.g.dart';

class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  @observable
  ScrollController scrollController = ScrollController();

  @observable
  double scrollPosition = 0.0;

  @action
  setScrollPosition(newValue) => scrollPosition = newValue;

  @observable
  int settingSelected = 0;

  @action
  setSettingSelected(int newValue) => settingSelected = newValue;
}
