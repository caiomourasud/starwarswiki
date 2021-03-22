import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/pages/characters/characters_page.dart';

import 'pages/home/home_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/characters', child: (_, __) => CharactersPage()),
  ];
}
