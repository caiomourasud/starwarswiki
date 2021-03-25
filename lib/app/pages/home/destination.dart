import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwarswiki/app/pages/characters/characters_page.dart';
import 'package:starwarswiki/app/pages/films/films_page.dart';
import 'package:starwarswiki/app/pages/planets/planets_page.dart';
import 'package:starwarswiki/app/pages/species/species_page.dart';
import 'package:starwarswiki/app/pages/starships/starships_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_page.dart';

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
      icon: CupertinoIcons.film,
      tooltip: 'Films'),
  Destination(
      pagina: DefaultView(
        page: CharactersPage(),
        actionList: [],
      ),
      icon: CupertinoIcons.rectangle_stack_person_crop_fill,
      tooltip: 'Characters'),
  Destination(
      pagina: DefaultView(
        page: PlanetsPage(),
        actionList: [],
      ),
      icon: CupertinoIcons.circle_grid_hex_fill,
      tooltip: 'Planets'),
  Destination(
      pagina: DefaultView(
        page: SpeciesPage(),
        actionList: [],
      ),
      icon: Icons.biotech_rounded,
      tooltip: 'Species'),
  Destination(
      pagina: DefaultView(
        page: StarshipsPage(),
        actionList: [],
      ),
      icon: CupertinoIcons.rocket_fill,
      tooltip: 'Starships'),
  Destination(
      pagina: DefaultView(
        page: VehiclesPage(),
        actionList: [],
      ),
      icon: CupertinoIcons.square_stack_3d_down_right_fill,
      tooltip: 'Vehicles')
];
