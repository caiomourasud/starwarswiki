import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/models/destination.dart';
import 'package:starwarswiki/app/pages/home_page.dart';
import 'package:starwarswiki/app/pages/settings_page.dart';

import 'default_view.dart';

final _appController = Modular.get<AppController>();

List<Destination> allDestinations = <Destination>[
  Destination(
      pagina: DefaultView(
        navigatorKey: _appController.homeNavigatorKey,
        page: HomePage(),
      ),
      navigatorKey: _appController.homeNavigatorKey,
      icon: CupertinoIcons.today,
      tooltip: 'Home'),
  Destination(
      pagina: DefaultView(
        navigatorKey: _appController.searchNavigatorKey,
        page: Container(),
      ),
      navigatorKey: _appController.searchNavigatorKey,
      icon: CupertinoIcons.search,
      tooltip: 'Search'),
  Destination(
      pagina: DefaultView(
        navigatorKey: _appController.favoritesNavigatorKey,
        page: Scaffold(),
      ),
      navigatorKey: _appController.favoritesNavigatorKey,
      icon: CupertinoIcons.suit_heart_fill,
      tooltip: 'Favorites'),
  Destination(
      pagina: DefaultView(
        navigatorKey: _appController.settingsNavigatorKey,
        page: SettingsPage(),
      ),
      navigatorKey: _appController.settingsNavigatorKey,
      icon: FontAwesomeIcons.jediOrder,
      tooltip: 'Settings'),
];
