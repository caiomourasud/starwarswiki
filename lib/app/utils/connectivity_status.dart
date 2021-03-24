import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/snack_bar_widget.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/utils/preferences.dart';

import '../app_controller.dart';

final _appController = Modular.get<AppController>();
final _charactersController = Modular.get<CharactersController>();

final Connectivity _connectivity = Connectivity();
StorageUtil prefs = StorageUtil();

class ConnectivityStatus {
  Future<void> initConnectivity(bool mounted) async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        print(result.toString());
        _appController.setConnectionStatus(result.toString());
        _charactersController.peopleFromDB();

        if (_appController.semInternet) {
          Timer(Duration(milliseconds: 300), () {
            SnackBarWidget().show(_appController.context!, 'Sem internet.');
          });
        } else {
          if (_charactersController.people.isEmpty) {
            if (!_appController.semInternet) {
              _charactersController.getPeople();
            }
          } else {
            prefs.getString('next').then((data) {
              if (data != '') {
                if (!_appController.semInternet) {
                  _charactersController.getMorePeople(data);
                }
              }
            });
          }
        }

        break;
      default:
        print(result.toString());
        _appController.setConnectionStatus(result.toString());
        break;
    }
  }
}
