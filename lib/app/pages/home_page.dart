import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/horizontal_list/custom_horizontal_list.dart';
import 'package:starwarswiki/app/components/navigation/custom_blur_appbar.dart';
import 'package:starwarswiki/app/controllers/characters_controller.dart';
import 'package:starwarswiki/app/controllers/films_controller.dart';
import 'package:starwarswiki/app/controllers/planets_controller.dart';
import 'package:starwarswiki/app/controllers/species_controller.dart';
import 'package:starwarswiki/app/controllers/starships_controller.dart';
import 'package:starwarswiki/app/controllers/vehicles_controller.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../controllers/home_controller.dart';

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
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints dimens) {
            return Row(
              children: [
                Container(
                    height: double.infinity,
                    width: dimens.maxWidth,
                    child: CustomScrollView(
                      controller: _homeController.scrollController,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: <Widget>[
                        Observer(builder: (_) {
                          return CustomBlurAppBar(
                              title: 'StarWars',
                              position: _homeController.scrollPosition);
                        }),
                        SliverToBoxAdapter(
                          child: Observer(builder: (_) {
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: CustomCardList()
                                    .cardList(
                                        context: context,
                                        films: _filmsController.films,
                                        filmsBackButton: 2,
                                        filmsHasDivider: false,
                                        characters:
                                            _charactersController.people,
                                        charactersBackButton: 2,
                                        charactersLines: 3,
                                        planets: _planetsController.planets,
                                        planetsBackButton: 2,
                                        planetsLines: 2,
                                        species: _speciesController.species,
                                        speciesBackButton: 2,
                                        speciesLines: 2,
                                        starships:
                                            _starshipsController.starships,
                                        starshipsBackButton: 2,
                                        starshipsLines:
                                            _starshipsController.starships.length > 4
                                                ? 3
                                                : 1,
                                        vehicles: _vehiclesController.vehicles,
                                        vehiclesBackButton:
                                            MediaQuery.of(context).size.width > md
                                                ? 2
                                                : 1,
                                        vehiclesLines: 2)
                                    .map((item) => CustomHorizontalList().list(
                                        context: context,
                                        title: item.title,
                                        height: item.height *
                                            (item.list.length > 12
                                                ? item.rows
                                                : 1),
                                        width: item.width *
                                            (item.list.length > 12
                                                ? item.rows
                                                : 1),
                                        rows:
                                            item.list.length > 12 ? item.rows : 1,
                                        cards: item.list,
                                        card: (index) => item.card(context, dimens, index),
                                        viewportFraction: item.viewportFraction,
                                        hasDivider: item.hasDivider,
                                        seeAll: true,
                                        onTap: () => item.onSeeAllTap(context)))
                                    .toList());
                          }),
                        ),
                      ],
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
