import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/models/card_list.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/pages/characters/character_details/character_details_page.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/characters/characters_page.dart';
import 'package:starwarswiki/app/pages/home/components/character_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/film_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/planet_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/specie_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/starship_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/vehicle_card_widget.dart';
import 'package:starwarswiki/app/pages/planets/planet_details/planet_details_page.dart';
import 'package:starwarswiki/app/pages/planets/planets_page.dart';
import 'package:starwarswiki/app/pages/species/specie_details/specie_details_page.dart';
import 'package:starwarswiki/app/pages/species/species_page.dart';
import 'package:starwarswiki/app/pages/starships/starship_details/starship_details_page.dart';
import 'package:starwarswiki/app/pages/starships/starships_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicle_details/vehicle_details_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_page.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../pages/films/films_page.dart';
import '../pages/films/film_details/film_details_page.dart';
import 'custom_card_dialog.dart';

final _charactersController = Modular.get<CharactersController>();

class CustomCardList {
  List<CardList> cardList(
          {List<Film>? films,
          String filmsTitle = 'Films',
          required int filmsBackButton,
          List<People>? characters,
          String charactersTitle = 'Characters',
          required int charactersBackButton,
          List<Planet>? planets,
          String planetsTitle = 'Planets',
          required int planetsBackButton,
          List<Specie>? species,
          String speciesTitle = 'Species',
          required int speciesBackButton,
          List<Starship>? starships,
          String starshipsTitle = 'Starships',
          required int starshipsBackButton,
          List<Vehicle>? vehicles,
          String vehiclesTitle = 'Vehicles',
          required int vehiclesBackButton}) =>
      [
        if (films != null)
          CardList(
            title: filmsTitle,
            list: films,
            height: 280.0,
            width: 170.0,
            rows: 1,
            card: (context, dimens, index) {
              return FilmCardWidget(
                film: films[index],
                onTap: () => MediaQuery.of(context).size.width > md &&
                        filmsBackButton == 2
                    ? CustomCardDialog().open(
                        context: context,
                        dimens: dimens,
                        item: FilmDetailsPage(
                            film: films[index], backButton: filmsBackButton),
                      )
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                        return FilmDetailsPage(
                            film: films[index],
                            backButton:
                                MediaQuery.of(context).size.width > md ? 2 : 1);
                      })),
              );
            },
            onSeeAllTap: (context) =>
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return FilmsPage(
                  backButton: filmsBackButton == 1
                      ? MediaQuery.of(context).size.width > md
                          ? 1
                          : 2
                      : 1);
            })),
          ),
        if (characters != null)
          CardList(
            title: charactersTitle,
            list: characters,
            height: 180.0,
            width: 140.0,
            rows: 1,
            card: (context, dimens, index) {
              return CharacterCardWidget(
                  character: characters[index],
                  onIconPressed: (id) =>
                      _charactersController.setFavorite(characters[index].id),
                  onTap: () => MediaQuery.of(context).size.width > md &&
                          charactersBackButton == 2
                      ? CustomCardDialog().open(
                          context: context,
                          dimens: dimens,
                          item: CharacterDetailsPage(
                              character: characters[index], backButton: 2),
                        )
                      : Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                          return CharacterDetailsPage(
                              character: characters[index],
                              backButton: MediaQuery.of(context).size.width > md
                                  ? 2
                                  : 1);
                        })));
            },
            onSeeAllTap: (context) {
              return Navigator.push(context,
                  CupertinoPageRoute(builder: (context) {
                return CharactersPage(
                    backButton: charactersBackButton == 1
                        ? MediaQuery.of(context).size.width > md
                            ? 2
                            : 1
                        : 1);
              }));
            },
          ),
        if (planets != null)
          CardList(
            title: planetsTitle,
            list: planets,
            height: 100.0,
            width: 100.0,
            rows: 2,
            card: (context, dimens, index) {
              return PlanetCardWidget(
                  planet: planets[index],
                  onTap: () => MediaQuery.of(context).size.width > md &&
                          planetsBackButton == 2
                      ? CustomCardDialog().open(
                          context: context,
                          dimens: dimens,
                          item: PlanetDetailsPage(
                              planet: planets[index], backButton: 2),
                        )
                      : Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                          return PlanetDetailsPage(
                              planet: planets[index],
                              backButton: MediaQuery.of(context).size.width > md
                                  ? 2
                                  : 1);
                        })));
            },
            onSeeAllTap: (context) {
              return Navigator.push(context,
                  CupertinoPageRoute(builder: (context) {
                return PlanetsPage();
              }));
            },
          ),
        if (species != null)
          CardList(
            title: speciesTitle,
            list: species,
            height: 80.0,
            width: 140.0,
            rows: 2,
            card: (context, dimens, index) {
              return SpecieCardWidget(
                  specie: species[index],
                  onTap: () => MediaQuery.of(context).size.width > md &&
                          speciesBackButton == 2
                      ? CustomCardDialog().open(
                          context: context,
                          dimens: dimens,
                          item: SpecieDetailsPage(
                              specie: species[index], backButton: 2),
                        )
                      : Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                          return SpecieDetailsPage(
                              specie: species[index],
                              backButton: MediaQuery.of(context).size.width > md
                                  ? 2
                                  : 1);
                        })));
            },
            onSeeAllTap: (context) {
              return Navigator.push(context,
                  CupertinoPageRoute(builder: (context) {
                return SpeciesPage();
              }));
            },
          ),
        if (starships != null)
          CardList(
            title: starshipsTitle,
            list: starships,
            height: 80.0,
            width: 140.0,
            rows: 2,
            card: (context, dimens, index) {
              return StarshipCardWidget(
                  starship: starships[index],
                  onTap: () => MediaQuery.of(context).size.width > md &&
                          starshipsBackButton == 2
                      ? CustomCardDialog().open(
                          context: context,
                          dimens: dimens,
                          item: StarshipDetailsPage(
                              starship: starships[index], backButton: 2),
                        )
                      : Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                          return StarshipDetailsPage(
                              starship: starships[index],
                              backButton: MediaQuery.of(context).size.width > md
                                  ? 2
                                  : 1);
                        })));
            },
            onSeeAllTap: (context) {
              return Navigator.push(context,
                  CupertinoPageRoute(builder: (context) {
                return StarshipsPage();
              }));
            },
          ),
        if (vehicles != null)
          CardList(
            title: vehiclesTitle,
            list: vehicles,
            height: 100.0,
            width: 100.0,
            rows: 2,
            card: (context, dimens, index) {
              return VehicleCardWidget(
                  vehicle: vehicles[index],
                  onTap: () => MediaQuery.of(context).size.width > md &&
                          vehiclesBackButton == 2
                      ? CustomCardDialog().open(
                          context: context,
                          dimens: dimens,
                          item: VehicleDetailsPage(
                              vehicle: vehicles[index], backButton: 2),
                        )
                      : Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                          return VehicleDetailsPage(
                              vehicle: vehicles[index],
                              backButton: MediaQuery.of(context).size.width > md
                                  ? 2
                                  : 1);
                        })));
            },
            onSeeAllTap: (context) {
              return Navigator.push(context,
                  CupertinoPageRoute(builder: (context) {
                return VehiclesPage();
              }));
            },
          )
      ];
}
