import 'package:flutter_modular/flutter_modular.dart';

import 'pages/characters/characters_controller.dart';
import 'pages/films/film_details/film_details_page.dart';
import 'pages/home/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CharactersController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute(
      '/filmdetails/:id',
      child: (_, args) => FilmDetailsPage(film: args.data),
    ),
  ];
}
