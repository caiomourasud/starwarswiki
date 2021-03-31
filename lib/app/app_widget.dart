import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/app_controller.dart';
import 'utils/connectivity_status.dart';

final _appController = Modular.get<AppController>();

late StreamSubscription<ConnectivityResult> connectivitySubscription;

final Connectivity _connectivity = Connectivity();

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    ConnectivityStatus().initConnectivity(mounted);
    connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(ConnectivityStatus().updateConnectionStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light));
    }

    return Observer(builder: (_) {
      return MaterialApp(
        title: 'StarWars',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            accentColor: Colors.blue[700],
            splashColor: Colors.transparent,
            scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
            cupertinoOverrideTheme:
                CupertinoThemeData(primaryColor: Colors.blue[700])),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.red[700],
            splashColor: Colors.transparent,
            scaffoldBackgroundColor: CupertinoColors.black,
            cupertinoOverrideTheme:
                CupertinoThemeData(primaryColor: Colors.red[700])),
        themeMode: _appController.appThemeMode,
        initialRoute: '/',
      ).modular();
    });
  }
}
