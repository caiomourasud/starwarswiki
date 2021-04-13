import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/themes/custom_themes.dart';

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
        theme: CustomThemes().light,
        darkTheme: CustomThemes().dark,
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
