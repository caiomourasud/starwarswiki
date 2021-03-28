import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/models/planet.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'planet_details/planet_details_page.dart';
import 'planets_controller.dart';

final _planetsController = Modular.get<PlanetsController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Converters conversores = Converters();

bool selectable = false;

class PlanetsPage extends StatefulWidget {
  @override
  _PlanetsPageState createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    _planetsController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _planetsController
        .setScrollPosition(_planetsController.scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _planetsController.setSearchSize(78.0);
      } else {
        _planetsController.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    _planetsController.setSearchText('');
    _planetsController.setSearchSize(0.0);
    FocusScope.of(context).unfocus();
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
                width: MediaQuery.of(context).size.width > md
                    ? 380.0
                    : dimens.maxWidth,
                child: NestedScrollView(
                    controller: _planetsController.scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    body: Observer(builder: (_) {
                      return Scrollbar(
                        child: CustomScrollView(
                          slivers: [
                            CupertinoSliverRefreshControl(
                              refreshTriggerPullDistance: 100.0,
                              refreshIndicatorExtent: 60.0,
                              onRefresh: () async {
                                await Future<void>.delayed(
                                    const Duration(milliseconds: 1000));
                                if (_planetsController.planets.isEmpty) {
                                  _planetsController.getPlanets();
                                } else {
                                  _prefs.getString('next_planets').then((data) {
                                    if (data != '') {
                                      _planetsController.getMorePlanets(data);
                                    }
                                  });
                                }
                              },
                            ),
                            _sliverBody(
                                _planetsController.filterPlanets, dimens),
                          ],
                        ),
                      );
                    }),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        if (!_focus.hasFocus ||
                            MediaQuery.of(context).size.width > md)
                          _sliverAppBar(),
                        if (_focus.hasFocus &&
                            MediaQuery.of(context).size.width <= md)
                          _appBar(),
                        Observer(builder: (_) {
                          return SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: SearchBarWidget(
                                  size: _planetsController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  backButton: 2,
                                  onChange: (text) {
                                    _planetsController.setSearchText(text);
                                  },
                                  cancelar: _cancelar,
                                  texto: 'Search...',
                                  fullDimens: dimens));
                        }),
                      ];
                    }),
              ),
              if (MediaQuery.of(context).size.width > md)
                VerticalDivider(
                  width: 0.1,
                ),
              if (MediaQuery.of(context).size.width > md)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    height: double.infinity,
                    width: 0.08,
                    color: Colors.grey,
                  ),
                ),
              Observer(
                builder: (_) {
                  return _planetsController.planetSelected.id == 0
                      ? Expanded(
                          child: Scaffold(
                              body: Center(child: Text('No planet selected'))),
                        )
                      : Expanded(
                          child: ClipRect(
                            child: PlanetDetailsPage(
                                planet: _planetsController.planetSelected,
                                backButton: 0),
                          ),
                        );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  _sliverAppBar() {
    return Observer(builder: (_) {
      return CupertinoSliverAppBarWidget(
        context: context,
        title: 'Planets',
        backButton: 2,
        position: _planetsController.scrollPosition,
        titleActions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 16.0,
              disable: false,
              onTap: () => _planetsController.setShowFavorites(null))
        ],
        actions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 0.0,
              disable: _planetsController.scrollPosition <= 35.0,
              onTap: () => _planetsController.setShowFavorites(null))
        ],
      );
    });
  }

  _appBar() {
    return Observer(builder: (_) {
      return SliverPersistentHeader(
          pinned: true,
          floating: false,
          delegate: CupertinoAppBarWidget(
            context: context,
            title: 'Films',
            backButton: 2,
            actions: [
              _listFavorites(
                  paddingTop: 4.0,
                  paddingRight: 0.0,
                  disable: false,
                  onTap: () => _planetsController.setShowFavorites(null))
            ],
          ));
    });
  }

  _sliverBody(List<Planet> planets, BoxConstraints dimens) {
    return _planetsController.res || _planetsController.planets.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTile(
                title: Text(_planetsController.planets[index].name),
                onTap: () {
                  if (MediaQuery.of(context).size.width <= md) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return PlanetDetailsPage(
                          planet: _planetsController.planets[index],
                          backButton: 1);
                    }));
                  }
                  setState(() {
                    _planetsController
                        .setPlanetSelected(_planetsController.planets[index]);
                  });
                },
              );
            }, childCount: planets.length),
          )
        : SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: dimens.maxHeight / 3),
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
  }

  _listFavorites(
      {required double paddingTop,
      required double paddingRight,
      required bool disable,
      required Function() onTap}) {
    return MouseRegion(
        cursor: disable ? MouseCursor.defer : SystemMouseCursors.click,
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop, right: paddingRight),
          child: disable
              ? Opacity(
                  opacity: 0,
                  child: CupertinoButton(
                      minSize: 34,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Icon(CupertinoIcons.square_favorites_alt_fill,
                          size: 28),
                      onPressed: null),
                )
              : Tooltip(
                  message: _planetsController.showFavorites
                      ? 'Listar todos'
                      : 'Listar favoritos',
                  child: CupertinoButton(
                      minSize: 34,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Icon(
                          _planetsController.showFavorites
                              ? CupertinoIcons.square_favorites_alt_fill
                              : CupertinoIcons.square_favorites_alt,
                          size: 28),
                      onPressed: () => onTap())),
        ));
  }
}
