import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'db/film_table.dart';
import 'db/people_table.dart';
import 'db/planet_table.dart';
import 'db/specie_table.dart';
import 'db/starship_table.dart';
import 'db/vehicle_table.dart';

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
    ..registerAdapter(FilmTableAdapter())
    ..registerAdapter(PeopleTableAdapter())
    ..registerAdapter(PlanetTableAdapter())
    ..registerAdapter(SpecieTableAdapter())
    ..registerAdapter(StarshipTableAdapter())
    ..registerAdapter(VehicleTableAdapter());
  await Hive.openBox<FilmTable>(filmsBox);
  await Hive.openBox<PeopleTable>(peopleBox);
  await Hive.openBox<PlanetTable>(planetsBox);
  await Hive.openBox<SpecieTable>(speciesBox);
  await Hive.openBox<StarshipTable>(starshipsBox);
  await Hive.openBox<VehicleTable>(vehiclesBox);

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
