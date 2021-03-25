import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/app_controller.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/pages/films/films_controller.dart';
import 'package:starwarswiki/app/pages/planets/planets_controller.dart';
import 'package:starwarswiki/app/pages/species/species_controller.dart';
import 'package:starwarswiki/app/pages/starships/starships_controller.dart';
import 'package:starwarswiki/app/pages/vehicles/vehicles_controller.dart';
import 'package:starwarswiki/code/breakpoints.dart';

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
                ? BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: indexSelected,
                    onTap: (int index) {
                      FocusScope.of(context).unfocus();
                      _onTap(index);
                    },
                    items: allDestinations.map((destination) {
                      return BottomNavigationBarItem(
                          tooltip: destination.tooltip,
                          icon: Stack(
                            children: <Widget>[
                              Icon(destination.icon),
                            ],
                          ),
                          label: '');
                    }).toList(),
                  )
                : null,
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
          _filmsController.scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }

        // Modular.to.pushNamed('/films');
        break;
      case 1:
        if (indexSelected == 1) {
          _charactersController.scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }
        // Modular.to.pushNamed('/characters');
        break;
      case 2:
        if (indexSelected == 2) {
          _planetsController.scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }
        // Modular.to.pushNamed('/planets');
        break;
      case 3:
        if (indexSelected == 3) {
          _speciesController.scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }
        // Modular.to.pushNamed('/species');
        break;
      case 4:
        if (indexSelected == 4) {
          _starshipsController.scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }
        // Modular.to.pushNamed('/starships');
        break;
      case 5:
        if (indexSelected == 5) {
          _vehiclesController.scrollController.animateTo(0.0,
              duration: Duration(milliseconds: 300), curve: Curves.linear);
        }
        // Modular.to.pushNamed('/vahicles');
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
        MediaQuery.of(context).size.width >= md) {
      return _navigationRail(context, dimens, _onTap);
    } else {
      return SizedBox();
    }
  }

  _navigationRail(context, dimens, onTap) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: dimens.maxHeight - 56.0),
          child: IntrinsicHeight(
            child: Material(
              child: NavigationRail(
                  unselectedIconTheme: Theme.of(context).iconTheme,
                  selectedIconTheme:
                      IconThemeData(color: Theme.of(context).accentColor),
                  backgroundColor: Colors.transparent,
                  labelType: NavigationRailLabelType.none,
                  // unselectedIconTheme: IconThemeData(color: Colors.grey[800]),
                  selectedIndex: indexSelected,
                  onDestinationSelected: onTap,
                  destinations: allDestinations.map((destination) {
                    return NavigationRailDestination(
                        label: Text(destination.tooltip),
                        icon: Icon(destination.icon));
                  }).toList()),
            ),
          ),
        ),
      ),
    );
  }
}
