import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'pages/characters/characters_controller.dart';
import 'pages/films/films_controller.dart';
import 'pages/home/home_controller.dart';
import 'pages/main/main_page.dart';
import 'pages/planets/planets_controller.dart';
import 'pages/settings/settings_controller.dart';
import 'pages/species/species_controller.dart';
import 'pages/starships/starships_controller.dart';
import 'pages/vehicles/vehicles_controller.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => AppController()),
    Bind((i) => HomeController()),
    Bind((i) => SettingsController()),
    Bind((i) => FilmsController()),
    Bind((i) => CharactersController()),
    Bind((i) => PlanetsController()),
    Bind((i) => SpeciesController()),
    Bind((i) => StarshipsController()),
    Bind((i) => VehiclesController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => MainPage()),
  ];
}
