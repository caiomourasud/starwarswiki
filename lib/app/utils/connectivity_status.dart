import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';
import 'package:starwarswiki/app/controllers/planets_controller.dart';
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/controllers/starships_controller.dart';
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';

import '../controllers/app_controller.dart';

final _appController = Modular.get<AppController>();
final _filmsController = Modular.get<FilmsController>();
final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

final Connectivity _connectivity = Connectivity();

class ConnectivityStatus {
  Future<void> initConnectivity(bool mounted) async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        print(result.toString());
        _appController.setConnectionStatus(result.toString());

        // Films
        if (_filmsController.films.isEmpty) {
          _filmsController.getFilms();
        } else {
          prefs.getString('next_films').then((data) {
            if (data != '') {
              _filmsController.getFilms(nextPage: data);
            }
          });
        }

        // Characters
        if (_charactersController.people.isEmpty) {
          _charactersController.getPeople();
        } else {
          prefs.getString('next_people').then((data) {
            if (data != '') {
              _charactersController.getPeople(nextPage: data);
            }
          });
        }

        // Planets
        if (_planetsController.planets.isEmpty) {
          _planetsController.getPlanets();
        } else {
          prefs.getString('next_planets').then((data) {
            if (data != '') {
              _planetsController.getPlanets(nextPage: data);
            }
          });
        }

        // Species
        if (_speciesController.species.isEmpty) {
          _speciesController.getSpecies();
        } else {
          prefs.getString('next_species').then((data) {
            if (data != '') {
              _speciesController.getSpecies(nextPage: data);
            }
          });
        }

        // Starships
        if (_starshipsController.starships.isEmpty) {
          _starshipsController.getStarships();
        } else {
          prefs.getString('next_starships').then((data) {
            if (data != '') {
              _starshipsController.getStarships(nextPage: data);
            }
          });
        }

        // Vehicles
        if (_vehiclesController.vehicles.isEmpty) {
          _vehiclesController.getVehicles();
        } else {
          prefs.getString('next_vehicles').then((data) {
            if (data != '') {
              _vehiclesController.getVehicles(nextPage: data);
            }
          });
        }

        break;
      default:
        print(result.toString());
        _appController.setConnectionStatus(result.toString());
        break;
    }
  }
}
