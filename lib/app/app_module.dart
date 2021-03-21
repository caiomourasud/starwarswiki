import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/pages/character/character_page.dart';

class AppModule extends Module {

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => CharacterPage()),
  ];

}