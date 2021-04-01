import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:starwarswiki/app/models/destination.dart';
import 'package:starwarswiki/app/pages/home_page.dart';
import 'package:starwarswiki/app/pages/settings_page.dart';

import 'default_view.dart';

List<Destination> allDestinations = <Destination>[
  Destination(
      pagina: DefaultView(
        page: HomePage(),
        actionList: [],
      ),
      icon: CupertinoIcons.today,
      tooltip: 'Home'),
  Destination(
      pagina: DefaultView(
        page: Scaffold(),
        actionList: [],
      ),
      icon: CupertinoIcons.search,
      tooltip: 'Search'),
  Destination(
      pagina: DefaultView(
        page: Scaffold(),
        actionList: [],
      ),
      icon: CupertinoIcons.suit_heart_fill,
      tooltip: 'Favorites'),
  Destination(
      pagina: DefaultView(
        page: SettingsPage(),
        actionList: [],
      ),
      icon:
          // Theme.of(_appController.context!).brightness == Brightness.light
          // ?
          FontAwesomeIcons.jediOrder
      // : FontAwesomeIcons.galacticRepublic
      ,
      tooltip: 'Settings'),
];
