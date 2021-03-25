import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/app_controller.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'components/custom_navigation_rail.dart';
import 'destination.dart';

final _appController = Modular.get<AppController>();
final _filmsController = Modular.get<FilmsController>();
final _charactersController = Modular.get<CharactersController>();
final _planetsController = Modular.get<PlanetsController>();
final _speciesController = Modular.get<SpeciesController>();
final _starshipsController = Modular.get<StarshipsController>();
final _vehiclesController = Modular.get<VehiclesController>();

int indexSelected = 0;
bool isMenuOpen = false;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _appController.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(builder: (context, dimens) {
          return Scaffold(
            bottomNavigationBar: dimens.maxWidth <= dimens.maxHeight ||
                    MediaQuery.of(context).size.width <= md
                ? CupertinoTabBar(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.black38
                            : Colors.white38,
                    currentIndex: indexSelected,
                    onTap: (index) {
                      FocusScope.of(context).unfocus();
                      _onTap(index);
                    },
                    // border: Border(bottom: BorderSide(color: Colors.transparent)),
                    items: allDestinations.map((destination) {
                      return BottomNavigationBarItem(
                        icon: Icon(destination.icon, size: 24),
                        tooltip: destination.tooltip,
                      );
                    }).toList(),
                  )
                : SizedBox(),
            body: Row(
              children: [
                _leftMenu(dimens),
                VerticalDivider(
                  width: 0.1,
                ),
                Expanded(child: _buildBody()),
              ],
            ),
          );
        }));
  }

  void _onTap(int index) {
    FocusScope.of(context).unfocus();
    switch (index) {
      case 0:
        if (indexSelected == 0) {
          _animateToTop(_filmsController.scrollController);
        }
        break;
      case 1:
        if (indexSelected == 1) {
          _animateToTop(_charactersController.scrollController);
        }
        break;
      case 2:
        if (indexSelected == 2) {
          _animateToTop(_planetsController.scrollController);
        }
        break;
      case 3:
        if (indexSelected == 3) {
          _animateToTop(_speciesController.scrollController);
        }
        break;
      case 4:
        if (indexSelected == 4) {
          _animateToTop(_starshipsController.scrollController);
        }
        break;
      case 5:
        if (indexSelected == 5) {
          _animateToTop(_vehiclesController.scrollController);
        }
        break;
      default:
    }
    if (mounted)
      setState(() {
        indexSelected = index;
      });
  }

  _buildBody() {
    return ClipRect(
      child: SafeArea(
        top: false,
        child: IndexedStack(
          index: indexSelected,
          children: allDestinations.map<Widget>((destination) {
            return destination.pagina;
          }).toList(),
        ),
      ),
    );
  }

  _leftMenu(BoxConstraints dimens) {
    if (dimens.maxWidth > dimens.maxHeight &&
        MediaQuery.of(context).size.width > md) {
      return CustomNavigationRail(
          dimens: dimens,
          indexSelected: indexSelected,
          itens: allDestinations,
          onTap: (index) => _onTap(index));
    } else {
      return SizedBox();
    }
  }

  _animateToTop(ScrollController controller) {
    controller.animateTo(0.0,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }
}
