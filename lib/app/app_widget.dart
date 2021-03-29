import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'utils/connectivity_status.dart';

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

    return MaterialApp(
      title: 'StarWars Wiki',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.red[700],
          scaffoldBackgroundColor: CupertinoColors.lightBackgroundGray,
          cupertinoOverrideTheme:
              CupertinoThemeData(primaryColor: Colors.red[700])),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.red[700],
          scaffoldBackgroundColor: CupertinoColors.black,
          cupertinoOverrideTheme:
              CupertinoThemeData(primaryColor: Colors.red[700])),
      themeMode: ThemeMode.system,
      initialRoute: '/',
    ).modular();
  }
}
