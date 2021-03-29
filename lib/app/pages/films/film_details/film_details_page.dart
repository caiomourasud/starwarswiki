import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
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

setList(widget) {
  characters.clear();
  planets.clear();
  starships.clear();
  vehicles.clear();
  species.clear();

  for (var person in widget.film.characters) {
    characters.addAll(_charactersController.people
        .where((character) => person == character.url));
  }
  for (var planet in widget.film.planets) {
    planets.addAll(_planetsController.planets.where((pl) => planet == pl.url));
  }
  for (var specie in widget.film.species) {
    species.addAll(_speciesController.species.where((sp) => specie == sp.url));
  }
  for (var starship in widget.film.starships) {
    starships.addAll(
        _starshipsController.starships.where((st) => starship == st.url));
  }
  for (var vehicle in widget.film.vehicles) {
    vehicles
        .addAll(_vehiclesController.vehicles.where((ve) => vehicle == ve.url));
  }
}

class _FilmDetailsPageState extends State<FilmDetailsPage> {
  @override
  Widget build(BuildContext context) {
    setList(widget);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= md ||
            (MediaQuery.of(context).size.width > md && widget.backButton == 2),
        brightness: Theme.of(context).brightness,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      width: 8.0,
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
                            SizedBox(height: 4.0),
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
                            SizedBox(height: 12.0),
                            Opacity(
                              opacity: 0.8,
                              child: Text(
                                'Release year',
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
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: CustomCardList()
                      .cardList(
                          context: context,
                          characters: characters,
                          charactersBackButton: widget.backButton == 2 ? 1 : 2,
                          planets: planets,
                          planetsBackButton: widget.backButton == 2 ? 1 : 2,
                          species: species,
                          speciesBackButton: widget.backButton == 2 ? 1 : 2,
                          starships: starships,
                          starshipsBackButton: widget.backButton == 2 ? 1 : 2,
                          vehicles: vehicles,
                          vehiclesBackButton: widget.backButton == 2 ? 1 : 2)
                      .map((item) => CustomHorizontalList().list(
                          context: context,
                          title: item.title,
                          height: item.height *
                              (item.list.length > 3 ? item.rows : 1),
                          width: item.width *
                              (item.list.length > 3 ? item.rows : 1),
                          rows: item.list.length > 3 ? item.rows : 1,
                          cards: item.list,
                          card: (index) => item.card(context, dimens, index),
                          hasDivider: item.hasDivider,
                          seeAll: false,
                          onTap: () => item.onSeeAllTap(context)))
                      .toList()),
              SizedBox(height: 48.0),
            ],
          ),
        );
      }),
    );
  }
}
