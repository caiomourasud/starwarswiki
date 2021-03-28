import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/code/breakpoints.dart';

final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

Planet? planet;
List<Starship> starships = [];
List<Vehicle> vehicles = [];
List<Specie> species = [];

class CharacterDetailsPage extends StatefulWidget {
  final People character;
  final int backButton;

  const CharacterDetailsPage(
      {Key? key, required this.character, required this.backButton})
      : super(key: key);
  @override
  _CharacterDetailsPageState createState() => _CharacterDetailsPageState();
}

setList(widget) {
  starships.clear();
  vehicles.clear();
  species.clear();
  if (widget.character.homeworld != '') {
    print(widget.character.homeworld);
    List<Planet> planetTemp = _planetsController.planets
        .where((pl) => pl.url == widget.character.homeworld)
        .toList();
    planet = planetTemp[0];
  }

  if (widget.character.species.isEmpty) {
    print(widget.character.species);
    species.addAll(_speciesController.species
        .where((sp) => sp.url == 'http://swapi.dev/api/species/1/'));
  } else {
    for (var specie in widget.character.species) {
      print(specie);
      species
          .addAll(_speciesController.species.where((sp) => specie == sp.url));
    }
  }
  for (var starship in widget.character.starships) {
    starships.addAll(
        _starshipsController.starships.where((st) => starship == st.url));
  }
  for (var vehicle in widget.character.vehicles) {
    vehicles
        .addAll(_vehiclesController.vehicles.where((ve) => vehicle == ve.url));
  }
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
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
          widget.character.name,
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
              SizedBox(height: 24.0),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: CustomCardList()
                      .cardList(
                          charactersBackButton: 1,
                          filmsBackButton: 1,
                          planetsBackButton: 1,
                          planetsTitle: 'Home world',
                          planets: planet != null ? [planet!] : null,
                          species: species.isNotEmpty ? species : null,
                          speciesBackButton: widget.backButton == 2 ? 1 : 2,
                          starships: starships.isNotEmpty ? starships : null,
                          starshipsBackButton: widget.backButton == 2 ? 1 : 2,
                          vehicles: vehicles.isNotEmpty ? vehicles : null,
                          vehiclesBackButton: widget.backButton == 2 ? 1 : 2)
                      .map((item) => CustomHorizontalList().list(
                          context: context,
                          title: item.title,
                          height: item.height *
                              (item.list.length > 12 ? item.rows : 1),
                          width: item.width *
                              (item.list.length > 12 ? item.rows : 1),
                          rows: item.list.length > 12 ? item.rows : 1,
                          cards: item.list,
                          card: (index) => item.card(context, dimens, index),
                          seeAll: false,
                          onTap: () => item.onSeeAllTap(context)))
                      .toList()),
            ],
          ),
        );
      }),
    );
  }
}
