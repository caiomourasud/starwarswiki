import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/card_list.dart';
import 'package:starwarswiki/app/components/custom_horizontal_list.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/code/breakpoints.dart';

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
                  child: NestedScrollView(
                      controller: _homeController.scrollController,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      body: Scrollbar(
                        child: CustomScrollView(
                          slivers: [
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
                                            starshipsLines: _starshipsController
                                                        .starships.length >
                                                    4
                                                ? 3
                                                : 1,
                                            vehicles:
                                                _vehiclesController.vehicles,
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
                                                (item.list.length > 12 ? item.rows : 1),
                                            rows: item.list.length > 12 ? item.rows : 1,
                                            cards: item.list,
                                            card: (index) => item.card(context, dimens, index),
                                            viewportFraction: item.viewportFraction,
                                            hasDivider: item.hasDivider,
                                            seeAll: true,
                                            onTap: () => item.onSeeAllTap(context)))
                                        .toList());
                              }),
                            ),
                            SliverToBoxAdapter(child: SizedBox(height: 52.0))
                          ],
                        ),
                      ),
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          _sliverAppBar(),
                        ];
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _sliverAppBar() {
    return Observer(builder: (_) {
      return CupertinoSliverNavigationBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        largeTitle: Text('StarWars',
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
