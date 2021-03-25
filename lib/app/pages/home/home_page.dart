import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/pages/characters/character_details/character_details_page.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/characters/characters_page.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
import 'package:starwarswiki/app/pages/films/films_page.dart';
import 'package:starwarswiki/app/pages/home/components/character_card_widget.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/planets/planets_page.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/species/species_page.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_page.dart';

import 'components/film_card_widget.dart';
import 'home_controller.dart';

final _homeController = Modular.get<HomeController>();
final _filmsController = Modular.get<FilmsController>();
final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _homeController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _homeController
        .setScrollPosition(_homeController.scrollController.position.pixels);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints dimens) {
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: dimens.maxWidth,
                  child: Observer(builder: (_) {
                    return NestedScrollView(
                        controller: _homeController.scrollController,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        body: Scrollbar(
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  child: Text(
                                      'The Star Wars API, or "swapi" (Swah-pee) is the world`s first quantified and programmatically-accessible data source for all the data from the Star Wars canon universe!'),
                                ),
                              ),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Films',
                                  height: 100.0,
                                  width: 200.0,
                                  cards: _filmsController.films,
                                  card: (index) {
                                    return FilmCardWidget(
                                        film: _filmsController.films[index],
                                        onTap: () {});
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return FilmsPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Characters',
                                  height: 200.0,
                                  width: 140.0,
                                  cards: _charactersController.people,
                                  card: (index) {
                                    return Observer(builder: (_) {
                                      return CharacterCardWidget(
                                        character:
                                            _charactersController.people[index],
                                        onIconPressed: (id) => setState(() =>
                                            _charactersController.setFavorite(
                                                _charactersController
                                                    .people[index].id)),
                                        onTap: () {
                                          Navigator.push(context,
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return CharacterDetailsPage(
                                                character: _charactersController
                                                    .people[index]);
                                          }));
                                        },
                                      );
                                    });
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return CharactersPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Planets',
                                  height: 100.0,
                                  width: 100.0,
                                  cards: _planetsController.planets,
                                  card: (index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Center(
                                          child: Text(_planetsController
                                              .planets[index].name)),
                                    );
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return PlanetsPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Species',
                                  height: 80.0,
                                  width: 140.0,
                                  cards: _speciesController.species,
                                  card: (index) {
                                    return Card(
                                        child: Center(
                                            child: Text(_speciesController
                                                .species[index].name)));
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return SpeciesPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Starships',
                                  height: 80.0,
                                  width: 140.0,
                                  cards: _starshipsController.starships,
                                  card: (index) {
                                    return Card(
                                        child: Center(
                                            child: Text(_starshipsController
                                                .starships[index].name)));
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return StarshipsPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 24.0)),
                              _sliverHorizontalList(
                                  title: 'Vehicles',
                                  height: 100.0,
                                  width: 100.0,
                                  cards: _vehiclesController.vehicles,
                                  card: (index) {
                                    return Card(
                                        child: Center(
                                            child: Text(_vehiclesController
                                                .vehicles[index].name)));
                                  },
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) {
                                              return VehiclesPage();
                                            },
                                            fullscreenDialog: true));
                                  }),
                              SliverToBoxAdapter(child: SizedBox(height: 52.0))
                            ],
                          ),
                        ),
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            _sliverAppBar(),
                          ];
                        });
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _sliverHorizontalList(
      {required String title,
      required double height,
      required double width,
      required List cards,
      required Function(int) card,
      required Function onTap}) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 18)),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text('See all',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).accentColor)),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      onTap();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: height,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Container(width: width, child: card(index));
              },
            ),
          ),
        ],
      ),
    );
  }

  _sliverAppBar() {
    return Observer(builder: (_) {
      return CupertinoSliverNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        largeTitle: Text('StarWars Wiki',
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black87
                    : Colors.yellow[600])),
        leading: CupertinoButton(
          minSize: 34,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(50.0),
          child: Icon(CupertinoIcons.person_crop_circle_fill, size: 26),
          onPressed: () {},
        ),
        border: _homeController.scrollPosition >
                142.0 + MediaQuery.of(context).viewPadding.top
            ? Border(bottom: BorderSide(width: 0, color: Colors.black26))
            : Border.all(color: Colors.transparent),
      );
    });
  }
}
