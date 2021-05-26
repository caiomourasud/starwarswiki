import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
part 'app_controller.g.dart';

StorageUtil prefs = StorageUtil();

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  bool isDarkTheme = true;

  @action
  setDarkTheme(bool value) {
    prefs.setBool('is_dark_theme', value);
    isDarkTheme = value;
  }

  @observable
  bool autoTheme = true;

  @action
  setAutoTheme(bool value) {
    prefs.setBool('auto_theme', value);
    autoTheme = value;
  }

  @observable
  BuildContext? context;

  @action
  setContext(currentContext) => context = currentContext;

  @observable
  String connectionStatus = 'Unknown';

  @action
  setConnectionStatus(String value) {
    print(value);
    return connectionStatus = value;
  }

  @computed
  bool get noInternet =>
      connectionStatus == 'ConnectivityResult.none' ||
      connectionStatus == 'Unknown';

  @observable
  int indexSelected = 0;

  @observable
  GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

  @observable
  GlobalKey<NavigatorState> searchNavigatorKey = GlobalKey<NavigatorState>();

  @observable
  GlobalKey<NavigatorState> favoritesNavigatorKey = GlobalKey<NavigatorState>();

  @observable
  GlobalKey<NavigatorState> settingsNavigatorKey = GlobalKey<NavigatorState>();
}
