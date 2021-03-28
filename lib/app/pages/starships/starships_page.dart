import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/models/starship.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'starship_details/starship_details_page.dart';
import 'starships_controller.dart';

final _starshipsController = Modular.get<StarshipsController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Converters conversores = Converters();

bool selectable = false;

class StarshipsPage extends StatefulWidget {
  @override
  _StarshipsPageState createState() => _StarshipsPageState();
}

class _StarshipsPageState extends State<StarshipsPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    _starshipsController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _starshipsController.setScrollPosition(
        _starshipsController.scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _starshipsController.setSearchSize(78.0);
      } else {
        _starshipsController.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    _starshipsController.setSearchText('');
    _starshipsController.setSearchSize(0.0);
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
                    controller: _starshipsController.scrollController,
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
                                if (_starshipsController.starships.isEmpty) {
                                  _starshipsController.getStarships();
                                } else {
                                  _prefs
                                      .getString('next_starships')
                                      .then((data) {
                                    if (data != '') {
                                      _starshipsController
                                          .getMoreStarships(data);
                                    }
                                  });
                                }
                              },
                            ),
                            _sliverBody(
                                _starshipsController.filterStarships, dimens),
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
                                  size: _starshipsController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  backButton: 2,
                                  onChange: (text) {
                                    _starshipsController.setSearchText(text);
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
                  return _starshipsController.starshipSelected.id == 0
                      ? Expanded(
                          child: Scaffold(
                              body:
                                  Center(child: Text('No starship selected'))),
                        )
                      : Expanded(
                          child: ClipRect(
                            child: StarshipDetailsPage(
                                starship: _starshipsController.starshipSelected,
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
        title: 'Starships',
        backButton: 2,
        position: _starshipsController.scrollPosition,
        titleActions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 16.0,
              disable: false,
              onTap: () => _starshipsController.setShowFavorites(null))
        ],
        actions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 0.0,
              disable: _starshipsController.scrollPosition <= 35.0,
              onTap: () => _starshipsController.setShowFavorites(null))
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
            title: 'Starships',
            backButton: 2,
            actions: [
              _listFavorites(
                  paddingTop: 4.0,
                  paddingRight: 0.0,
                  disable: false,
                  onTap: () => _starshipsController.setShowFavorites(null))
            ],
          ));
    });
  }

  _sliverBody(List<Starship> starships, BoxConstraints dimens) {
    return _starshipsController.res || _starshipsController.starships.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTile(
                title: Text(_starshipsController.starships[index].name),
                onTap: () {
                  if (MediaQuery.of(context).size.width <= md) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return StarshipDetailsPage(
                          starship: _starshipsController.starships[index],
                          backButton: 1);
                    }));
                  }
                  setState(() {
                    _starshipsController.setStarshipSelected(
                        _starshipsController.starships[index]);
                  });
                },
              );
            }, childCount: starships.length),
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
                  message: _starshipsController.showFavorites
                      ? 'Listar todos'
                      : 'Listar favoritos',
                  child: CupertinoButton(
                      minSize: 34,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Icon(
                          _starshipsController.showFavorites
                              ? CupertinoIcons.square_favorites_alt_fill
                              : CupertinoIcons.square_favorites_alt,
                          size: 28),
                      onPressed: () => onTap())),
        ));
  }
}
