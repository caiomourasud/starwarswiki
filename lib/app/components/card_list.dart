import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/models/card_list.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/pages/details_pages/character_details_page.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/components/cards/character_card_widget.dart';
import 'package:starwarswiki/app/components/cards/film_card_widget.dart';
import 'package:starwarswiki/app/components/cards/planet_card_widget.dart';
import 'package:starwarswiki/app/components/cards/specie_card_widget.dart';
import 'package:starwarswiki/app/components/cards/starship_card_widget.dart';
import 'package:starwarswiki/app/components/cards/vehicle_card_widget.dart';
import 'package:starwarswiki/app/components/list_tiles/character_listtile_widget.dart';
import 'package:starwarswiki/app/pages/default_list_page.dart';
import 'package:starwarswiki/app/components/list_tiles/film_listtile_widget.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/planet_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/planet_details_page.dart';
import 'package:starwarswiki/app/controllers/planets_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/specie_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/specie_details_page.dart';
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/starship_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/starship_details_page.dart';
import 'package:starwarswiki/app/controllers/starships_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/vehicle_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/vehicle_details_page.dart';
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';
import 'package:starwarswiki/app/repository/characters_repository.dart';
import 'package:starwarswiki/app/repository/films_repository.dart';
import 'package:starwarswiki/app/repository/planets_repository.dart';
import 'package:starwarswiki/app/repository/species_repository.dart';
import 'package:starwarswiki/app/repository/starships_repository.dart';
import 'package:starwarswiki/app/repository/vehicles_repository.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../pages/details_pages/film_details_page.dart';
import 'custom_card_dialog.dart';

final _filmsRepository = FilmsRepositiry();
final _filmsController = Modular.get<FilmsController>();
final _charactersRepository = CharactersRepositiry();
final _charactersController = Modular.get<CharactersController>();
final _planetsRepository = PlanetsRepositiry();
final _planetsController = Modular.get<PlanetsController>();
final _speciesRepository = SpeciesRepositiry();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsRepository = StarshipsRepositiry();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesRepository = VehiclesRepositiry();
final _vehiclesController = Modular.get<VehiclesController>();

class CustomCardList {
  List<CardList> cardList({
    required BuildContext context,
    List<Film>? films,
    String filmsTitle = 'Films',
    int filmsBackButton = 1,
    bool filmsHasDivider = true,
    int filmsLines = 1,
    double filmsViewportFraction = 0.45,
    List<People>? characters,
    String charactersTitle = 'Characters',
    int charactersBackButton = 1,
    bool charactersHasDivider = true,
    int charactersLines = 1,
    double charactersViewportFraction = 0.9,
    List<Planet>? planets,
    String planetsTitle = 'Planets',
    int planetsBackButton = 1,
    bool planetsHasDivider = true,
    int planetsLines = 1,
    double planetsViewportFraction = 0.30,
    List<Specie>? species,
    String speciesTitle = 'Species',
    int speciesBackButton = 1,
    bool speciesHasDivider = true,
    int speciesLines = 1,
    double speciesViewportFraction = 0.45,
    List<Starship>? starships,
    String starshipsTitle = 'Starships',
    int starshipsBackButton = 1,
    bool starshipsHasDivider = true,
    int starshipsLines = 1,
    double starshipsViewportFraction = 0.9,
    List<Vehicle>? vehicles,
    String vehiclesTitle = 'Vehicles',
    int vehiclesBackButton = 1,
    bool vehiclesHasDivider = true,
    int vehiclesLines = 1,
    double vehiclesViewportFraction = 0.30,
  }) {
    double width = MediaQuery.of(context).size.width;

    return [
      if (films != null)
        CardList(
          title: filmsTitle,
          list: films,
          height: width <= sm ? width * 0.65 + 54.0 : 240.0 + 54.0,
          width: width <= sm ? width * 0.45 : 160.0,
          rows: filmsLines,
          viewportFraction: filmsViewportFraction,
          hasDivider: filmsHasDivider,
          card: (context, dimens, index) {
            return FilmCardWidget(
              film: films[index],
              onTap: () => width > md && filmsBackButton == 2
                  ? CustomCardDialog().open(
                      context: context,
                      item: FilmDetailsPage(
                          film: films[index], backButton: filmsBackButton),
                    )
                  : Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                      return FilmDetailsPage(
                          film: films[index], backButton: width > md ? 2 : 1);
                    })),
            );
          },
          onSeeAllTap: (context) =>
              Navigator.push(context, CupertinoPageRoute(builder: (context) {
            return Observer(builder: (_) {
              return DefaultListPage(
                  title: 'Films',
                  backButton: filmsBackButton == 1
                      ? width > md
                          ? 1
                          : 2
                      : 1,
                  searchText: _filmsController.searchText,
                  setSearchText: _filmsController.setSearchText,
                  setShowFavorites: null,
                  getList: () => _filmsController.getFilms(),
                  res: _filmsController.res,
                  nextText: 'next_films',
                  list: _filmsController.films,
                  filterList: _filmsController.filterFilms,
                  actions: [],
                  titleActions: [],
                  appBarActions: [],
                  showFavorites: null,
                  listTile: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    return FilmListTileWidget(
                        film: _filmsController.filterFilms[index],
                        onTap: (item) {
                          FocusScope.of(context).unfocus();
                          if (width <= md) {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return FilmDetailsPage(
                                  film: item,
                                  backButton: filmsBackButton == 1
                                      ? width > md
                                          ? 1
                                          : 2
                                      : 1);
                            }));
                          }
                          _filmsController.setFilmSelected(
                              _filmsController.filterFilms[index].id);
                        },
                        filmSelected: _filmsController.filmSelected);
                  }, childCount: _filmsController.filterFilms.length)),
                  detailsPage: FilmDetailsPage(
                    backButton: 0,
                    film:
                        _filmsRepository.getById(_filmsController.filmSelected),
                  ),
                  itemSelectedId: _filmsController.filmSelected,
                  noItemSelected: 'No film selected');
            });
          })),
        ),
      if (characters != null)
        CardList(
          title: charactersTitle,
          list: characters,
          height: 88.0,
          width: width <= sm ? width * 0.9 : 320.0,
          rows: charactersLines,
          viewportFraction: charactersViewportFraction,
          hasDivider: charactersHasDivider,
          card: (context, dimens, index) {
            return CharacterCardWidget(
                character: characters[index],
                onIconPressed: (id) =>
                    _charactersRepository.setFavorite(characters[index].id),
                onTap: () => width > md && charactersBackButton == 2
                    ? CustomCardDialog().open(
                        context: context,
                        item: CharacterDetailsPage(
                            character: characters[index], backButton: 2),
                      )
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                        return CharacterDetailsPage(
                            character: characters[index],
                            backButton: width > md ? 2 : 1);
                      })));
          },
          onSeeAllTap: (context) {
            return Navigator.push(context,
                CupertinoPageRoute(builder: (context) {
              return Observer(builder: (_) {
                return DefaultListPage(
                    title: 'Characters',
                    backButton: charactersBackButton == 1
                        ? width > md
                            ? 1
                            : 2
                        : 1,
                    searchText: _charactersController.searchText,
                    setSearchText: _charactersController.setSearchText,
                    setShowFavorites: (show) =>
                        _charactersController.setShowFavorites(show),
                    getList: () => _charactersController.getPeople(),
                    res: _charactersController.res,
                    nextText: 'next_people',
                    list: _charactersController.people,
                    filterList: _charactersController.filterCharacters,
                    actions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 0.0,
                          disable: false,
                          onTap: () =>
                              _charactersController.setShowFavorites(null))
                    ],
                    titleActions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 16.0,
                          disable: false,
                          onTap: () =>
                              _charactersController.setShowFavorites(null))
                    ],
                    appBarActions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 0.0,
                          disable: false,
                          onTap: () =>
                              _charactersController.setShowFavorites(null))
                    ],
                    showFavorites: _charactersController.showFavorites,
                    listTile: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return CharacterListTileWidget(
                          person: _charactersController.filterCharacters[index],
                          onTap: (item) {
                            FocusScope.of(context).unfocus();
                            if (width <= md) {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return CharacterDetailsPage(
                                    character: item,
                                    backButton: charactersBackButton == 1
                                        ? width > md
                                            ? 1
                                            : 2
                                        : 1);
                              }));
                            }
                            _charactersController.setPersonSelected(
                                _charactersController
                                    .filterCharacters[index].id);
                          },
                          personSelected: _charactersController.personSelected,
                          onFavoriteTap: (index) {
                            _charactersRepository.setFavorite(index);
                          });
                    },
                            childCount:
                                _charactersController.filterCharacters.length)),
                    detailsPage: CharacterDetailsPage(
                      backButton: 0,
                      character: _charactersRepository
                          .getById(_charactersController.personSelected),
                    ),
                    itemSelectedId: _charactersController.personSelected,
                    noItemSelected: 'No character selected');
              });
            }));
          },
        ),
      if (planets != null)
        CardList(
          title: planetsTitle,
          list: planets,
          height: width <= sm ? width * 0.28 + 54.0 : 110.0 + 54.0,
          width: width <= sm ? width * 0.30 : 120.0,
          rows: planetsLines,
          viewportFraction: planetsViewportFraction,
          hasDivider: planetsHasDivider,
          card: (context, dimens, index) {
            return PlanetCardWidget(
                planet: planets[index],
                onTap: () => width > md && planetsBackButton == 2
                    ? CustomCardDialog().open(
                        context: context,
                        item: PlanetDetailsPage(
                            planet: planets[index], backButton: 2),
                      )
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                        return PlanetDetailsPage(
                            planet: planets[index],
                            backButton: width > md ? 2 : 1);
                      })));
          },
          onSeeAllTap: (context) {
            return Navigator.push(context,
                CupertinoPageRoute(builder: (context) {
              return Observer(builder: (_) {
                return DefaultListPage(
                    title: 'Planets',
                    backButton: planetsBackButton == 1
                        ? width > md
                            ? 1
                            : 2
                        : 1,
                    searchText: _planetsController.searchText,
                    setSearchText: _planetsController.setSearchText,
                    setShowFavorites: null,
                    getList: () => _planetsController.getPlanets(),
                    res: _planetsController.res,
                    nextText: 'next_planets',
                    list: _planetsController.planets,
                    filterList: _planetsController.filterPlanets,
                    actions: [],
                    titleActions: [],
                    appBarActions: [],
                    showFavorites: null,
                    listTile: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return PlanetListTileWidget(
                          planet: _planetsController.filterPlanets[index],
                          onTap: (item) {
                            FocusScope.of(context).unfocus();
                            if (width <= md) {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return PlanetDetailsPage(
                                    planet: item,
                                    backButton: planetsBackButton == 1
                                        ? width > md
                                            ? 1
                                            : 2
                                        : 1);
                              }));
                            }
                            _planetsController.setPlanetSelected(
                                _planetsController.filterPlanets[index].id);
                          },
                          planetSelected: _planetsController.planetSelected);
                    }, childCount: _planetsController.filterPlanets.length)),
                    detailsPage: PlanetDetailsPage(
                      backButton: 0,
                      planet: _planetsRepository
                          .getById(_planetsController.planetSelected),
                    ),
                    itemSelectedId: _planetsController.planetSelected,
                    noItemSelected: 'No planet selected');
              });
            }));
          },
        ),
      if (species != null)
        CardList(
          title: speciesTitle,
          list: species,
          height: 126.0,
          width: width <= sm ? width * 0.45 : 150.0,
          rows: speciesLines,
          viewportFraction: speciesViewportFraction,
          hasDivider: speciesHasDivider,
          card: (context, dimens, index) {
            return SpecieCardWidget(
                specie: species[index],
                onTap: () => width > md && speciesBackButton == 2
                    ? CustomCardDialog().open(
                        context: context,
                        item: SpecieDetailsPage(
                            specie: species[index], backButton: 2),
                      )
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                        return SpecieDetailsPage(
                            specie: species[index],
                            backButton: width > md ? 2 : 1);
                      })));
          },
          onSeeAllTap: (context) {
            return Navigator.push(context,
                CupertinoPageRoute(builder: (context) {
              return Observer(builder: (_) {
                return DefaultListPage(
                    title: 'Species',
                    backButton: speciesBackButton == 1
                        ? width > md
                            ? 2
                            : 1
                        : 1,
                    searchText: _speciesController.searchText,
                    setSearchText: _speciesController.setSearchText,
                    setShowFavorites: null,
                    getList: () => _speciesController.getSpecies(),
                    res: _speciesController.res,
                    nextText: 'next_species',
                    list: _speciesController.species,
                    filterList: _speciesController.filterSpecies,
                    actions: [],
                    titleActions: [],
                    appBarActions: [],
                    showFavorites: null,
                    listTile: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return SpecieListTileWidget(
                          specie: _speciesController.filterSpecies[index],
                          onTap: (item) {
                            FocusScope.of(context).unfocus();
                            if (width <= md) {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return SpecieDetailsPage(
                                    specie: item,
                                    backButton: filmsBackButton == 1
                                        ? width > md
                                            ? 1
                                            : 2
                                        : 1);
                              }));
                            }
                            _speciesController.setSpecieSelected(
                                _speciesController.filterSpecies[index].id);
                          },
                          specieSelected: _speciesController.specieSelected);
                    }, childCount: _speciesController.filterSpecies.length)),
                    detailsPage: SpecieDetailsPage(
                        backButton: 0,
                        specie: _speciesRepository
                            .getById(_speciesController.specieSelected)),
                    itemSelectedId: _speciesController.specieSelected,
                    noItemSelected: 'No specie selected');
              });
            }));
          },
        ),
      if (starships != null)
        CardList(
          title: starshipsTitle,
          list: starships,
          height: 88.0,
          width: width <= sm ? width * 0.9 : 320.0,
          rows: starshipsLines,
          viewportFraction: starshipsViewportFraction,
          hasDivider: starshipsHasDivider,
          card: (context, dimens, index) {
            return StarshipCardWidget(
                starship: starships[index],
                onTap: () => width > md && starshipsBackButton == 2
                    ? CustomCardDialog().open(
                        context: context,
                        item: StarshipDetailsPage(
                            starship: starships[index], backButton: 2),
                      )
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                        return StarshipDetailsPage(
                            starship: starships[index],
                            backButton: width > md ? 2 : 1);
                      })));
          },
          onSeeAllTap: (context) {
            return Navigator.push(context,
                CupertinoPageRoute(builder: (context) {
              return Observer(builder: (_) {
                return DefaultListPage(
                    title: 'Starships',
                    backButton: starshipsBackButton == 1
                        ? width > md
                            ? 2
                            : 1
                        : 1,
                    searchText: _starshipsController.searchText,
                    setSearchText: _starshipsController.setSearchText,
                    setShowFavorites: null,
                    getList: () => _starshipsController.getStarships(),
                    res: _starshipsController.res,
                    nextText: 'next_starships',
                    list: _starshipsController.starships,
                    filterList: _starshipsController.filterStarships,
                    actions: [],
                    titleActions: [],
                    appBarActions: [],
                    showFavorites: null,
                    listTile: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return StarshipListTileWidget(
                          starship: _starshipsController.filterStarships[index],
                          onTap: (item) {
                            FocusScope.of(context).unfocus();
                            if (width <= md) {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return StarshipDetailsPage(
                                    starship: item,
                                    backButton: starshipsBackButton == 1
                                        ? width > md
                                            ? 1
                                            : 2
                                        : 1);
                              }));
                            }
                            _starshipsController.setStarshipSelected(
                                _starshipsController.filterStarships[index].id);
                          },
                          starshipSelected:
                              _starshipsController.starshipSelected);
                    },
                            childCount:
                                _starshipsController.filterStarships.length)),
                    detailsPage: StarshipDetailsPage(
                      backButton: 0,
                      starship: _starshipsRepository
                          .getById(_starshipsController.starshipSelected),
                    ),
                    itemSelectedId: _starshipsController.starshipSelected,
                    noItemSelected: 'No starship selected');
              });
            }));
          },
        ),
      if (vehicles != null)
        CardList(
          title: vehiclesTitle,
          list: vehicles,
          height: width <= sm ? width * 0.28 + 54.0 : 110.0 + 54.0,
          width: width <= sm ? width * 0.30 : 120.0,
          rows: vehiclesLines,
          viewportFraction: vehiclesViewportFraction,
          hasDivider: vehiclesHasDivider,
          card: (context, dimens, index) {
            return VehicleCardWidget(
                vehicle: vehicles[index],
                onTap: () => width > md && vehiclesBackButton == 2
                    ? CustomCardDialog().open(
                        context: context,
                        item: VehicleDetailsPage(
                            vehicle: vehicles[index], backButton: 2),
                      )
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                        return VehicleDetailsPage(
                            vehicle: vehicles[index],
                            backButton: width > md ? 2 : 1);
                      })));
          },
          onSeeAllTap: (context) {
            return Navigator.push(context,
                CupertinoPageRoute(builder: (context) {
              return Observer(builder: (_) {
                return DefaultListPage(
                    title: 'Vehicles',
                    backButton: vehiclesBackButton == 1
                        ? width > md
                            ? 2
                            : 1
                        : 1,
                    searchText: _vehiclesController.searchText,
                    setSearchText: _vehiclesController.setSearchText,
                    setShowFavorites: null,
                    getList: () => _vehiclesController.getVehicles(),
                    res: _vehiclesController.res,
                    nextText: 'next_vehicles',
                    list: _vehiclesController.vehicles,
                    filterList: _vehiclesController.filterVehicles,
                    actions: [],
                    titleActions: [],
                    appBarActions: [],
                    showFavorites: null,
                    listTile: SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return VehicleListTileWidget(
                          vehicle: _vehiclesController.filterVehicles[index],
                          onTap: (item) {
                            FocusScope.of(context).unfocus();
                            if (width <= md) {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                return VehicleDetailsPage(
                                    vehicle: item,
                                    backButton: vehiclesBackButton == 1
                                        ? width > md
                                            ? 1
                                            : 2
                                        : 1);
                              }));
                            }
                            _vehiclesController.setVehicleSelected(
                                _vehiclesController.filterVehicles[index].id);
                          },
                          vehicleSelected: _vehiclesController.vehicleSelected);
                    }, childCount: _vehiclesController.filterVehicles.length)),
                    detailsPage: VehicleDetailsPage(
                      backButton: 0,
                      vehicle: _vehiclesRepository
                          .getById(_vehiclesController.vehicleSelected),
                    ),
                    itemSelectedId: _vehiclesController.vehicleSelected,
                    noItemSelected: 'No vehicle selected');
              });
            }));
          },
        )
    ];
  }
}

_listFavorites(
    {required double paddingTop,
    required double paddingRight,
    required bool disable,
    required Function() onTap}) {
  return MouseRegion(
      cursor: disable ? MouseCursor.defer : SystemMouseCursors.click,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop, right: paddingRight),
        child: disable
            ? Opacity(
                opacity: 0,
                child: CupertinoButton(
                    minSize: 34,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Icon(CupertinoIcons.square_favorites_alt_fill,
                        size: 28),
                    onPressed: null),
              )
            : Tooltip(
                message: _charactersController.showFavorites
                    ? 'List all'
                    : 'List favorites',
                child: CupertinoButton(
                    minSize: 34,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Icon(
                        _charactersController.showFavorites
                            ? CupertinoIcons.square_favorites_alt_fill
                            : CupertinoIcons.square_favorites_alt,
                        size: 28),
                    onPressed: () => onTap())),
      ));
}
