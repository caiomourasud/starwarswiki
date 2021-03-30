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

import 'components/planet_listtile_widget.dart';
import 'planet_details/planet_details_page.dart';
import 'planets_controller.dart';

final _planetsController = Modular.get<PlanetsController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Converters conversores = Converters();

bool selectable = false;

class PlanetsPage extends StatefulWidget {
  final int backButton;

  const PlanetsPage({Key? key, required this.backButton}) : super(key: key);
  @override
  _PlanetsPageState createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    super.initState();
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
    return CupertinoSliverAppBarWidget(
      context: context,
      title: 'Planets',
      backButton: 2,
      titleActions: [],
      actions: [],
    );
  }

  _appBar() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: CupertinoAppBarWidget(
          context: context,
          title: 'Films',
          backButton: 2,
          actions: [],
        ));
  }

  _sliverBody(List<Planet> planets, BoxConstraints dimens) {
    return _planetsController.res || _planetsController.planets.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return PlanetListTileWidget(
                  planet: _planetsController.filterPlanets[index],
                  onTap: (item) {
                    if (MediaQuery.of(context).size.width <= md) {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return PlanetDetailsPage(planet: item, backButton: 2);
                      }));
                    }
                    setState(() {
                      _planetsController.setPlanetSelected(
                          _planetsController.filterPlanets[index]);
                    });
                  },
                  planetSelected: _planetsController.planetSelected);
            }, childCount: _planetsController.filterPlanets.length),
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
}
