import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/models/destination.dart';
import 'package:starwarswiki/app/pages/home_page.dart';
import 'package:starwarswiki/app/pages/settings_page.dart';

import 'default_view.dart';

final GlobalKey<NavigatorState> homeNavigatorKey =
    new GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> searchNavigatorKey =
    new GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> favoritesNavigatorKey =
    new GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> settingsNavigatorKey =
    new GlobalKey<NavigatorState>();

List<Destination> allDestinations = <Destination>[
  Destination(
      pagina: DefaultView(
        navigatorKey: homeNavigatorKey,
        page: HomePage(),
        actionList: [],
      ),
      navigatorKey: homeNavigatorKey,
      icon: CupertinoIcons.today,
      tooltip: 'Home'),
  Destination(
      pagina: DefaultView(
        navigatorKey: searchNavigatorKey,
        page: Scaffold(),
        actionList: [],
      ),
      navigatorKey: searchNavigatorKey,
      icon: CupertinoIcons.search,
      tooltip: 'Search'),
  Destination(
      pagina: DefaultView(
        navigatorKey: favoritesNavigatorKey,
        page: Scaffold(),
        actionList: [],
      ),
      navigatorKey: favoritesNavigatorKey,
      icon: CupertinoIcons.suit_heart_fill,
      tooltip: 'Favorites'),
  Destination(
      pagina: DefaultView(
        navigatorKey: settingsNavigatorKey,
        page: SettingsPage(),
        actionList: [],
      ),
      navigatorKey: settingsNavigatorKey,
      icon:
          // Theme.of(_appController.context!).brightness == Brightness.light
          // ?
          FontAwesomeIcons.jediOrder
      // : FontAwesomeIcons.galacticRepublic
      ,
      tooltip: 'Settings'),
];
