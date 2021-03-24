import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  BuildContext? context;

  @action
  setContext(currentContext) => context = currentContext;

  @observable
  String connectionStatus = 'Unknown';

  @action
  setConnectionStatus(String newValue) {
    print(newValue);
    return connectionStatus = newValue;
  }

  @computed
  bool get noInternet =>
      connectionStatus == 'ConnectivityResult.none' ||
      connectionStatus == 'Unknown';
}
