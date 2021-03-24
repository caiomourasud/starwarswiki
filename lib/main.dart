import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/models/film.dart';
import 'app/models/people.dart';
import 'app/models/planet.dart';
import 'app/models/specie.dart';
import 'app/models/starship.dart';
import 'app/models/vehicle.dart';

import 'code/config.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _enablePlatformOverrideForDesktop();

  if (!kIsWeb) {
    final dynamic appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path as String);
  }

  Hive
    ..registerAdapter(FilmAdapter())
    ..registerAdapter(PeopleAdapter())
    ..registerAdapter(PlanetAdapter())
    ..registerAdapter(SpecieAdapter())
    ..registerAdapter(StarshipAdapter())
    ..registerAdapter(VehicleAdapter());

  await Hive.openBox<Film>(filmsBox);
  await Hive.openBox<People>(peopleBox);
  await Hive.openBox<Planet>(planetsBox);
  await Hive.openBox<Specie>(speciesBox);
  await Hive.openBox<Starship>(starshipsBox);
  await Hive.openBox<Vehicle>(vehiclesBox);

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
