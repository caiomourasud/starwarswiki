import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/models/vehicle.dart';
import 'package:starwarswiki/app/pages/planets/planet_details/planet_details_page.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/image_generator.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../characters_controller.dart';

final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

Planet? planet;
List<Starship> starships = [];
List<Vehicle> vehicles = [];
List<Specie> species = [];

class TestList {
  final String title;
  final String value;
  final IconData icon;

  TestList({
    required this.title,
    required this.value,
    required this.icon,
  });
}

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
    List<Planet> planetTemp = _planetsController.planets
        .where((pl) => pl.url == widget.character.homeworld)
        .toList();
    planet = planetTemp[0];
  }

  if (widget.character.species.isEmpty) {
    species.addAll(_speciesController.species
        .where((sp) => sp.url == 'http://swapi.dev/api/species/1/'));
  } else {
    for (var specie in widget.character.species) {
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

    List<TestList> info = [
      TestList(
          title: 'Height',
          value: Converters().toDouble(widget.character.height, 1),
          icon: CupertinoIcons.resize_v),
      TestList(
          title: 'Mass',
          value: Converters().toDouble(widget.character.mass, 0),
          icon: CupertinoIcons.timer),
      TestList(
          title: 'Birth year',
          value: widget.character.birthYear,
          icon: CupertinoIcons.gift),
      TestList(
          title: 'Hair color',
          value: widget.character.hairColor,
          icon: Icons.color_lens_rounded),
      TestList(
          title: 'Eye color',
          value: widget.character.eyeColor,
          icon: CupertinoIcons.eye),
      TestList(
          title: 'Skin color',
          value: widget.character.skinColor,
          icon: CupertinoIcons.hand_raised_fill)
    ];

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
        trailing: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
                message: widget.character.isFavorite ? 'Remover' : 'Favoritar',
                child: CupertinoButton(
                    minSize: 30,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(50.0),
                    child: Icon(
                        widget.character.isFavorite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        size: 28),
                    onPressed: () => setState(
                          () => _charactersController
                              .setFavorite(widget.character.id),
                        )))),
      ),
      body: LayoutBuilder(builder: (context, dimens) {
        return Scrollbar(
          child: ListView(
            padding: EdgeInsets.fromLTRB(0.0, 22.0, 0.0, 22.0),
            children: [
              Container(
                height: 140.0,
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        height: 136.0,
                        width: 130.0,
                        decoration: BoxDecoration(
                            color: CupertinoColors.darkBackgroundGray,
                            image: DecorationImage(
                                image: NetworkImage(
                                    ImageGenerator.generateImage(
                                        id: widget.character.id,
                                        type: 'characters')),
                                alignment: Alignment.topCenter,
                                fit: BoxFit.cover)),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.character.name,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                            ),
                            SizedBox(height: 2.0),
                            Row(
                              children: [
                                Opacity(
                                  opacity: 0.8,
                                  child: Text(
                                    widget.character.gender,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                SizedBox(width: 2.0),
                                Converters()
                                    .setGender(widget.character.gender, 12.0)
                              ],
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => Navigator.push(context,
                                    CupertinoPageRoute(builder: (context) {
                                  return PlanetDetailsPage(
                                      planet: planet!,
                                      backButton:
                                          MediaQuery.of(context).size.width > md
                                              ? 2
                                              : 1);
                                })),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons.location_solid,
                                        size: 12,
                                        color: Theme.of(context).accentColor),
                                    SizedBox(width: 2.0),
                                    Text(
                                      planet!.name,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0)
                          ]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(height: 0.0),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 12.0, right: 16.0, bottom: 0.0),
                child: Text('Characteristics', style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Wrap(
                    children: info.map((item) {
                  return Container(
                    height: 70.0,
                    width: 140.0,
                    decoration: new BoxDecoration(
                        color: Color(0x12cfcfcf),
                        border: Border.all(color: Theme.of(context).focusColor),
                        borderRadius: new BorderRadius.all(
                          const Radius.circular(6.0),
                        )),
                    margin: EdgeInsets.only(left: 0.0, top: 8.0, right: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: 0.8,
                                child: Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.overline,
                                ),
                              ),
                              SizedBox(
                                height: 6.0,
                              ),
                              Text(
                                item.value,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(flex: 2, child: Container()),
                              Opacity(opacity: 0.1, child: Icon(item.icon)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList()),
              ),
              SizedBox(height: 18.0),
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: CustomCardList()
                      .cardList(
                          context: context,
                          speciesTitle: 'Specie',
                          species: species.isNotEmpty ? species : null,
                          speciesBackButton: widget.backButton == 2 ? 1 : 2,
                          starships: starships.isNotEmpty ? starships : null,
                          starshipsBackButton: widget.backButton == 2 ? 1 : 2,
                          starshipsLines: starships.length > 4 ? 2 : 1,
                          vehicles: vehicles.isNotEmpty ? vehicles : null,
                          vehiclesBackButton: widget.backButton == 2 ? 1 : 2)
                      .map((item) => CustomHorizontalList().list(
                          context: context,
                          title: item.title,
                          height: item.height *
                              (item.list.length > 3 ? item.rows : 1),
                          width: item.width *
                              (item.list.length > 3 ? item.rows : 1),
                          rows: item.list.length > 3 ? item.rows : 1,
                          viewportFraction: item.viewportFraction,
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
