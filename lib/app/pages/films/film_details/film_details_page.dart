import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
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
import 'package:starwarswiki/app/pages/home/components/planet_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/specie_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/starship_card_widget.dart';
import 'package:starwarswiki/app/pages/home/components/vehicle_card_widget.dart';
import 'package:starwarswiki/app/pages/planets/planet_details/planet_details_page.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/specie_details/specie_details_page.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/species/species_page.dart';
import 'package:starwarswiki/app/pages/starships/starship_details/starship_details_page.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicle_details/vehicle_details_page.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_page.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

List<People> characters = [];
List<Planet> planets = [];
List<Starship> starships = [];
List<Vehicle> vehicles = [];
List<Specie> species = [];

class FilmDetailsPage extends StatefulWidget {
  final Film film;
  final int backButton;

  const FilmDetailsPage(
      {Key? key, required this.film, required this.backButton})
      : super(key: key);
  @override
  _FilmDetailsPageState createState() => _FilmDetailsPageState();
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  @override
  void initState() {
    characters = [];
    planets = [];
    starships = [];
    vehicles = [];
    species = [];

    for (var person in widget.film.characters) {
      characters.addAll(_charactersController.people
          .where((character) => person == character.url));
    }
    for (var planet in widget.film.planets) {
      planets
          .addAll(_planetsController.planets.where((pl) => planet == pl.url));
    }
    for (var specie in widget.film.species) {
      species
          .addAll(_speciesController.species.where((sp) => specie == sp.url));
    }
    for (var starship in widget.film.starships) {
      starships.addAll(
          _starshipsController.starships.where((st) => starship == st.url));
    }
    for (var vehicle in widget.film.vehicles) {
      vehicles.addAll(
          _vehiclesController.vehicles.where((ve) => vehicle == ve.url));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backButton == 2 ? Colors.transparent : null,
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md ||
            widget.backButton == 1 ||
            widget.backButton == 2,
        brightness: Theme.of(context).brightness,
        backgroundColor: widget.backButton == 2
            ? Theme.of(context).bottomAppBarColor
            : Theme.of(context).scaffoldBackgroundColor,
        leading: widget.backButton == 2
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.maybePop(context),
                child: Icon(CupertinoIcons.clear),
              )
            : null,
        middle: Text(
          widget.film.title,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: 280.0,
                        width: 170.0,
                        decoration: BoxDecoration(
                            color: CupertinoColors.darkBackgroundGray,
                            image: DecorationImage(
                              image: NetworkImage(ImageGenerator.generateImage(
                                  id: widget.film.id, type: 'films')),
                              alignment: Alignment.topCenter,
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.1), BlendMode.xor),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 22.0,
                    ),
                    Flexible(
                      child: Container(
                        height: 280.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.film.title,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            SizedBox(height: 6.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Episode ${Converters().setRoman(widget.film.episodeId)}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Director',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Text(
                              widget.film.director,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(height: 12.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Producer',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Text(
                              widget.film.producer,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(height: 24.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Release date',
                                style: Theme.of(context).textTheme.overline,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy').format(
                                  DateTime.parse(widget.film.releaseDate)),
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              _sliverHorizontalList(
                  title: 'Characters',
                  height: 180.0,
                  width: 140.0,
                  rows: 1,
                  cards: characters,
                  card: (index) {
                    return CharacterCardWidget(
                      character: characters[index],
                      onIconPressed: (id) => setState(() =>
                          _charactersController
                              .setFavorite(characters[index].id)),
                      onTap: () {
                        MediaQuery.of(context).size.width > md
                            ? _openCardDialog(
                                dimens: dimens,
                                item: CharacterDetailsPage(
                                    character: characters[index],
                                    backButton: 2),
                              )
                            : Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                                return CharacterDetailsPage(
                                    character: characters[index],
                                    backButton: 1);
                              }));
                      },
                    );
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
              SizedBox(height: 24.0),
              _sliverHorizontalList(
                  title: 'Planets',
                  height: 100.0 * (planets.length > 12 ? 2 : 1),
                  width: 100.0 * (planets.length > 12 ? 2 : 1),
                  rows: planets.length > 12 ? 2 : 1,
                  cards: planets,
                  card: (index) {
                    return PlanetCardWidget(
                      planet: planets[index],
                      onTap: () {
                        MediaQuery.of(context).size.width > md
                            ? _openCardDialog(
                                dimens: dimens,
                                item: PlanetDetailsPage(
                                    planet: planets[index], backButton: 2),
                              )
                            : Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                                return PlanetDetailsPage(
                                    planet: planets[index], backButton: 1);
                              }));
                      },
                    );
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
              SizedBox(height: 24.0),
              _sliverHorizontalList(
                  title: 'Species',
                  height: 80.0 * (species.length > 12 ? 2 : 1),
                  width: 140.0 * (species.length > 12 ? 2 : 1),
                  rows: (species.length > 12 ? 2 : 1),
                  cards: species,
                  card: (index) {
                    return SpecieCardWidget(
                      specie: species[index],
                      onTap: () {
                        MediaQuery.of(context).size.width > md
                            ? _openCardDialog(
                                dimens: dimens,
                                item: SpecieDetailsPage(
                                    specie: species[index], backButton: 2),
                              )
                            : Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                                return SpecieDetailsPage(
                                    specie: species[index], backButton: 1);
                              }));
                      },
                    );
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
              SizedBox(height: 24.0),
              _sliverHorizontalList(
                  title: 'Starships',
                  height: 80.0 * (starships.length > 12 ? 2 : 1),
                  width: 140.0 * (starships.length > 12 ? 2 : 1),
                  rows: (starships.length > 12 ? 2 : 1),
                  cards: starships,
                  card: (index) {
                    return StarshipCardWidget(
                      starship: starships[index],
                      onTap: () {
                        MediaQuery.of(context).size.width > md
                            ? _openCardDialog(
                                dimens: dimens,
                                item: StarshipDetailsPage(
                                    starship: starships[index], backButton: 2),
                              )
                            : Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                                return StarshipDetailsPage(
                                    starship: starships[index], backButton: 1);
                              }));
                      },
                    );
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
              SizedBox(height: 24.0),
              _sliverHorizontalList(
                  title: 'Vehicles',
                  height: 100.0 * (vehicles.length > 12 ? 2 : 1),
                  width: 100.0 * (vehicles.length > 12 ? 2 : 1),
                  rows: (vehicles.length > 12 ? 2 : 1),
                  cards: vehicles,
                  card: (index) {
                    return VehicleCardWidget(
                      vehicle: vehicles[index],
                      onTap: () {
                        MediaQuery.of(context).size.width > md
                            ? _openCardDialog(
                                dimens: dimens,
                                item: VehicleDetailsPage(
                                    vehicle: vehicles[index], backButton: 2),
                              )
                            : Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                                return VehicleDetailsPage(
                                    vehicle: vehicles[index], backButton: 1);
                              }));
                      },
                    );
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
              SizedBox(height: 48.0),
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Opacity(
              //       opacity: 0.8,
              //       child: Text(
              //         'Opening crawl',
              //         style: Theme.of(context).textTheme.overline,
              //       ),
              //     ),
              //     SizedBox(height: 8.0),
              //     Flexible(
              //       child: Text(
              //         widget.film.openingCrawl,
              //         textAlign: TextAlign.center,
              //         style: Theme.of(context).textTheme.headline5,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      }),
    );
  }

  _sliverHorizontalList(
      {required String title,
      required double height,
      required double width,
      required List cards,
      required Function(int) card,
      required int rows,
      required Function onTap}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                          fontSize: 14, color: Theme.of(context).accentColor)),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    onTap();
                  },
                ),
              ),
            ],
          ),
        ),
        if (rows > 1)
          Container(
              height: height,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(width: width, child: card(index));
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: rows / 4,
                  maxCrossAxisExtent: height / rows,
                  mainAxisExtent: (width / rows) - 0.10,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: cards.length,
              )),
        if (rows == 1)
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
    );
  }

  _openCardDialog({required BoxConstraints dimens, required Widget item}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(6.0)),
            backgroundColor: Theme.of(context).bottomAppBarColor,
            content: ConstrainedBox(
              constraints: BoxConstraints(minWidth: dimens.maxWidth / 1.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: item,
              ),
            ));
      },
    );
  }
}
