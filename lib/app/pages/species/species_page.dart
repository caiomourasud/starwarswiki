import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/models/specie.dart';
import 'package:starwarswiki/app/utils/conversores.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'specie_details/specie_details_page.dart';
import 'species_controller.dart';

final _speciesController = Modular.get<SpeciesController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Conversores conversores = Conversores();

bool selectable = false;

class SpeciesPage extends StatefulWidget {
  @override
  _SpeciesPageState createState() => _SpeciesPageState();
}

class _SpeciesPageState extends State<SpeciesPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    _speciesController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _speciesController
        .setScrollPosition(_speciesController.scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _speciesController.setSearchSize(78.0);
      } else {
        _speciesController.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    _speciesController.setSearchText('');
    _speciesController.setSearchSize(0.0);
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
                width: MediaQuery.of(context).size.width >= md
                    ? 380.0
                    : dimens.maxWidth,
                child: NestedScrollView(
                    controller: _speciesController.scrollController,
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
                                if (_speciesController.species.isEmpty) {
                                  _speciesController.getSpecies();
                                } else {
                                  _prefs.getString('next_species').then((data) {
                                    if (data != '') {
                                      _speciesController.getMoreSpecies(data);
                                    }
                                  });
                                }
                              },
                            ),
                            _sliverBody(
                                _speciesController.filterSpecies, dimens),
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
                                  size: _speciesController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  onChange: (text) {
                                    _speciesController.setSearchText(text);
                                  },
                                  cancelar: _cancelar,
                                  texto: 'Search...',
                                  fullDimens: dimens));
                        }),
                      ];
                    }),
              ),
              if (MediaQuery.of(context).size.width >= md)
                VerticalDivider(
                  width: 0.1,
                ),
              if (MediaQuery.of(context).size.width >= md)
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
                  return _speciesController.specieSelected.id == 0
                      ? Expanded(
                          child: Scaffold(
                              body: Center(child: Text('No specie selected'))),
                        )
                      : Expanded(
                          child: ClipRect(
                            child: SpecieDetailsPage(
                                specie: _speciesController.specieSelected),
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
        title: 'Species',
        leading: CupertinoButton(
            minSize: 34,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.transparent,
            child: Icon(CupertinoIcons.person_crop_circle_fill,
                size: 26, color: Colors.red[600]),
            onPressed: () {
              setState(() {
                _speciesController.clearListSpecies();
                _speciesController.clearSpeciesBox();
                _prefs.delete('next_species');
              });
            }),
        position: _speciesController.scrollPosition,
        titleActions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 16.0,
              disable: false,
              onTap: () => _speciesController.setShowFavorites(null))
        ],
        actions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 0.0,
              disable: _speciesController.scrollPosition <= 35.0,
              onTap: () => _speciesController.setShowFavorites(null))
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
            title: 'Species',
            leading: CupertinoButton(
              minSize: 34,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.transparent,
              child: Icon(CupertinoIcons.person_crop_circle_fill,
                  size: 26, color: Colors.red[600]),
              onPressed: () {
                setState(() {
                  _speciesController.clearListSpecies();
                  _speciesController.clearSpeciesBox();
                  _prefs.delete('next_species');
                });
              },
            ),
            actions: [
              _listFavorites(
                  paddingTop: 4.0,
                  paddingRight: 0.0,
                  disable: false,
                  onTap: () => _speciesController.setShowFavorites(null))
            ],
          ));
    });
  }

  _sliverBody(List<Specie> species, BoxConstraints dimens) {
    return _speciesController.res || _speciesController.species.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTile(
                title: Text(_speciesController.species[index].name),
                onTap: () {
                  if (MediaQuery.of(context).size.width <= md) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return SpecieDetailsPage(
                          specie: _speciesController.species[index]);
                    }));
                  }
                  setState(() {
                    _speciesController
                        .setSpecieSelected(_speciesController.species[index]);
                  });
                },
              );
              // return ListTileWidget(
              //   personSelected: _charactersController.personSelected,
              //   person: people[index],
              //   dimens: dimens,
              //   onTap: (character) {
              //     if (MediaQuery.of(context).size.width <= md) {
              //       Navigator.push(context,
              //           CupertinoPageRoute(builder: (context) {
              //         return CharacterDetailPage(character: character);
              //       }));
              //     }
              //     setState(() {
              //       _charactersController.setPersonSelected(character);
              //     });
              //   },
              //   onFavoriteTap: (id) {
              //     setState(() {
              //       _charactersController.setFavorito(id);
              //     });
              //   },
              // );
            }, childCount: species.length),
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
                      color: Colors.transparent,
                      child: Icon(CupertinoIcons.square_favorites_alt_fill,
                          size: 28, color: Colors.red[600]),
                      onPressed: null),
                )
              : Tooltip(
                  message: _speciesController.showFavorites
                      ? 'Listar todos'
                      : 'Listar favoritos',
                  child: CupertinoButton(
                      minSize: 34,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.transparent,
                      child: Icon(
                          _speciesController.showFavorites
                              ? CupertinoIcons.square_favorites_alt_fill
                              : CupertinoIcons.square_favorites_alt,
                          size: 28,
                          color: Colors.red[600]),
                      onPressed: () => onTap())),
        ));
  }
}
