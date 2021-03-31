import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/pages/home_page.dart';
import 'package:starwarswiki/app/pages/settings_page.dart';

import 'default_view.dart';

class Destination {
  final Widget pagina;
  final IconData icon;
  final String tooltip;
  const Destination(
      {required this.pagina, required this.icon, required this.tooltip});
}

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
      icon: Icons.menu_rounded,
      tooltip: 'Settings'),
];
