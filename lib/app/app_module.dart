import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/app_controller.dart';
import 'controllers/characters_controller.dart';
import 'controllers/films_controller.dart';
import 'controllers/home_controller.dart';
import 'pages/main_page.dart';
import 'controllers/planets_controller.dart';
import 'controllers/settings_controller.dart';
import 'controllers/species_controller.dart';
import 'controllers/starships_controller.dart';
import 'controllers/vehicles_controller.dart';

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
