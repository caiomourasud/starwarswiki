import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';

final _appController = Modular.get<AppController>();

class DefaultView extends StatelessWidget {
  final Widget page;
  final GlobalKey<NavigatorState>? navigatorKey;
  const DefaultView({required this.page, this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
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
        themeMode: _appController.autoTheme
            ? ThemeMode.system
            : _appController.isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
        navigatorKey: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return CupertinoPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return page;
            },
          );
        },
      );
    });
  }
}
