import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/pages/characters/characters_page.dart';
import 'package:starwarswiki/app/pages/films/films_page.dart';

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
        page: FilmsPage(),
        actionList: [],
      ),
      icon: Icons.home,
      tooltip: 'Films'),
  Destination(
      pagina: DefaultView(
        page: CharactersPage(),
        actionList: [],
      ),
      icon: Icons.person,
      tooltip: 'Characters'),
  Destination(
      pagina: DefaultView(
        page: FilmsPage(),
        actionList: [],
      ),
      icon: Icons.today,
      tooltip: 'Planets'),
  Destination(
      pagina: DefaultView(
        page: FilmsPage(),
        actionList: [],
      ),
      icon: Icons.forum,
      tooltip: 'Species'),
  Destination(
      pagina: DefaultView(
        page: FilmsPage(),
        actionList: [],
      ),
      icon: Icons.all_inbox_rounded,
      tooltip: 'Starships'),
  Destination(
      pagina: DefaultView(
        page: FilmsPage(),
        actionList: [],
      ),
      icon: Icons.settings,
      tooltip: 'Vehicles')
];
