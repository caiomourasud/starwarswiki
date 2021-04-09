import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/horizontal_list/cards/half_card_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/cards/small_line_widget.dart';
import 'package:starwarswiki/app/components/horizontal_list/cards/third_card_widget.dart';
import 'package:starwarswiki/app/models/card_list.dart';
import 'package:starwarswiki/app/models/database/film.dart';
import 'package:starwarswiki/app/models/database/people.dart';
import 'package:starwarswiki/app/models/database/planet.dart';
import 'package:starwarswiki/app/models/database/specie.dart';
import 'package:starwarswiki/app/models/database/starship.dart';
import 'package:starwarswiki/app/models/database/vehicle.dart';
import 'package:starwarswiki/app/pages/details_pages/home/character_details_page.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/character_listtile_widget.dart';
import 'package:starwarswiki/app/pages/default_list_page.dart';
import 'package:starwarswiki/app/components/list_tiles/film_listtile_widget.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/planet_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/home/planet_details_page.dart';
import 'package:starwarswiki/app/controllers/planets_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/specie_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/home/specie_details_page.dart';
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/starship_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/home/starship_details_page.dart';
import 'package:starwarswiki/app/controllers/starships_controller.dart';
import 'package:starwarswiki/app/components/list_tiles/vehicle_listtile_widget.dart';
import 'package:starwarswiki/app/pages/details_pages/home/vehicle_details_page.dart';
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';
import 'package:starwarswiki/app/repositories/characters_repository.dart';
import 'package:starwarswiki/app/repositories/films_repository.dart';
import 'package:starwarswiki/app/repositories/planets_repository.dart';
import 'package:starwarswiki/app/repositories/species_repository.dart';
import 'package:starwarswiki/app/repositories/starships_repository.dart';
import 'package:starwarswiki/app/repositories/vehicles_repository.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../pages/details_pages/home/film_details_page.dart';
import 'custom_card_dialog.dart';

import '../utils/capitalize.dart';

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
            return HalfCardWidget(
                title: films[index].title,
                subtitle:
                    'Episode ${Converters().setRoman(films[index].episodeId)}',
                image: ImageGenerator.generateImage(
                    id: films[index].id, type: 'films'),
                height: 240.0,
                viewportFractionHeight: 0.65,
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
                      })));
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
                  actions: [
                    _listFavorites(
                        paddingTop: 4.0,
                        paddingRight: 10.0,
                        isSelected: _filmsController.showFavorites,
                        onTap: () => _filmsController.setShowFavorites(null))
                  ],
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
                        filmSelected: _filmsController.filmSelected,
                        onFavoriteTap: (index) {
                          _filmsRepository.setFavorite(
                              context: context, id: index);
                        });
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
            return SmallLineWidget(
                topText: Row(
                  children: [
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        Converters().getSpecie(characters[index].species),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.overline,
                      ),
                    ),
                    SizedBox(width: 2.0),
                    Converters().setGender(characters[index].gender, 9.0)
                  ],
                ),
                title: characters[index].name,
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: 0.8,
                            child: Text('Height',
                                style: Theme.of(context).textTheme.overline),
                          ),
                          Text(
                              Converters()
                                  .toDouble(characters[index].height, 1),
                              style: Converters().toDouble(
                                          characters[index].height, 1) ==
                                      'unknown'
                                  ? Theme.of(context).textTheme.overline
                                  : Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                      SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Opacity(
                            opacity: 0.8,
                            child: Text('Mass',
                                style: Theme.of(context).textTheme.overline),
                          ),
                          Text(
                            Converters().toDouble(characters[index].mass, 0),
                            style: Converters()
                                        .toDouble(characters[index].mass, 0) ==
                                    'unknown'
                                ? Theme.of(context).textTheme.overline
                                : Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                button: CupertinoButton(
                  minSize: 30,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  child: Icon(
                      characters[index].isFavorite
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      size: 28),
                  onPressed: () => _charactersRepository.setFavorite(
                      context: context, id: characters[index].id),
                ),
                image: ImageGenerator.generateImage(
                    id: characters[index].id, type: 'characters'),
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
                          paddingRight: 10.0,
                          isSelected: _charactersController.showFavorites,
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
                            _charactersRepository.setFavorite(
                                context: context, id: index);
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
            return ThirdCardWidget(
                title: planets[index].name,
                subtitle: planets[index].terrain.capitalize(),
                image: ImageGenerator.generateImage(
                    id: planets[index].id, type: 'planets'),
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
                    actions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 10.0,
                          isSelected: _planetsController.showFavorites,
                          onTap: () =>
                              _planetsController.setShowFavorites(null))
                    ],
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
                          planetSelected: _planetsController.planetSelected,
                          onFavoriteTap: (index) {
                            _planetsRepository.setFavorite(
                                context: context, id: index);
                          });
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
          height: width <= sm ? width * 0.225 + 54.0 : 100.0 + 54.0,
          width: width <= sm ? width * 0.45 : 200.0,
          rows: speciesLines,
          viewportFraction: speciesViewportFraction,
          hasDivider: speciesHasDivider,
          card: (context, dimens, index) {
            return HalfCardWidget(
                title: species[index].name,
                subtitle: species[index].classification.capitalize(),
                image: ImageGenerator.generateImage(
                    id: species[index].id, type: 'species'),
                height: 100.0,
                viewportFractionHeight: 0.225,
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
                    actions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 10.0,
                          isSelected: _speciesController.showFavorites,
                          onTap: () =>
                              _speciesController.setShowFavorites(null))
                    ],
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
                          specieSelected: _speciesController.specieSelected,
                          onFavoriteTap: (index) {
                            _speciesRepository.setFavorite(
                                context: context, id: index);
                          });
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
            return SmallLineWidget(
                topText: Row(
                  children: [
                    Expanded(
                      child: Opacity(
                        opacity: 0.8,
                        child: Text(
                          starships[index].model,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.overline,
                        ),
                      ),
                    ),
                  ],
                ),
                title: starships[index].name,
                subtitle: Row(
                  children: [
                    SizedBox(width: 1.0),
                    Expanded(
                      child: Opacity(
                        opacity: 0.8,
                        child: Text(
                          starships[index].manufacturer,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(height: 1.0),
                        ),
                      ),
                    ),
                  ],
                ),
                image: ImageGenerator.generateImage(
                    id: starships[index].id, type: 'starships'),
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
                    actions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 10.0,
                          isSelected: _starshipsController.showFavorites,
                          onTap: () =>
                              _starshipsController.setShowFavorites(null))
                    ],
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
                              _starshipsController.starshipSelected,
                          onFavoriteTap: (index) {
                            _starshipsRepository.setFavorite(
                                context: context, id: index);
                          });
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
            return ThirdCardWidget(
                title: vehicles[index].name,
                subtitle: vehicles[index].model.capitalize(),
                image: ImageGenerator.generateImage(
                    id: vehicles[index].id, type: 'vehicles'),
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
                    actions: [
                      _listFavorites(
                          paddingTop: 4.0,
                          paddingRight: 10.0,
                          isSelected: _vehiclesController.showFavorites,
                          onTap: () =>
                              _vehiclesController.setShowFavorites(null))
                    ],
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
                          vehicleSelected: _vehiclesController.vehicleSelected,
                          onFavoriteTap: (index) {
                            _vehiclesRepository.setFavorite(
                                context: context, id: index);
                          });
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
    required bool isSelected,
    required Function() onTap}) {
  return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop, right: paddingRight),
        child: Tooltip(
            message: isSelected ? 'List all' : 'List favorites',
            child: CupertinoButton(
                minSize: 34,
                padding: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(50.0),
                child: Icon(
                    isSelected
                        ? CupertinoIcons.square_favorites_alt_fill
                        : CupertinoIcons.square_favorites_alt,
                    size: 28),
                onPressed: () => onTap())),
      ));
}
