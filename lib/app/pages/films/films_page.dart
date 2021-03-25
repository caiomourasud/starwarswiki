import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/models/film.dart';
import 'package:starwarswiki/app/utils/converters.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import 'film_details/film_details_page.dart';
import 'films_controller.dart';

final _filmsController = Modular.get<FilmsController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Converters conversores = Converters();

bool selectable = false;

class FilmsPage extends StatefulWidget {
  @override
  _FilmsPageState createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    _filmsController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _filmsController
        .setScrollPosition(_filmsController.scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _filmsController.setSearchSize(78.0);
      } else {
        _filmsController.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    _filmsController.setSearchText('');
    _filmsController.setSearchSize(0.0);
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
                    controller: _filmsController.scrollController,
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
                                if (_filmsController.films.isEmpty) {
                                  _filmsController.getFilms();
                                } else {
                                  _prefs.getString('next_people').then((data) {
                                    if (data != '') {
                                      _filmsController.getMoreFilms(data);
                                    }
                                  });
                                }
                              },
                            ),
                            _sliverBody(_filmsController.filterFilms, dimens),
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
                                  size: _filmsController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  onChange: (text) {
                                    _filmsController.setSearchText(text);
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
                  return _filmsController.filmSelected.id == 0
                      ? Expanded(
                          child: Scaffold(
                              body: Center(child: Text('No film selected'))),
                        )
                      : Expanded(
                          child: ClipRect(
                            child: FilmDetailsPage(
                                film: _filmsController.filmSelected),
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
        title: 'Films',
        position: _filmsController.scrollPosition,
        titleActions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 16.0,
              disable: false,
              onTap: () => _filmsController.setShowFavorites(null))
        ],
        actions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 0.0,
              disable: _filmsController.scrollPosition <= 35.0,
              onTap: () => _filmsController.setShowFavorites(null))
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
            actions: [
              _listFavorites(
                  paddingTop: 4.0,
                  paddingRight: 0.0,
                  disable: false,
                  onTap: () => _filmsController.setShowFavorites(null))
            ],
          ));
    });
  }

  _sliverBody(List<Film> films, BoxConstraints dimens) {
    return _filmsController.res || _filmsController.films.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTile(
                title: Text(_filmsController.films[index].title),
                onTap: () {
                  if (MediaQuery.of(context).size.width <= md) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return FilmDetailsPage(
                          film: _filmsController.films[index]);
                    }));
                  }
                  setState(() {
                    _filmsController
                        .setFilmSelected(_filmsController.films[index]);
                  });
                },
              );
            }, childCount: films.length),
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
                  message: _filmsController.showFavorites
                      ? 'Listar todos'
                      : 'Listar favoritos',
                  child: CupertinoButton(
                      minSize: 34,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      child: Icon(
                          _filmsController.showFavorites
                              ? CupertinoIcons.square_favorites_alt_fill
                              : CupertinoIcons.square_favorites_alt,
                          size: 28),
                      onPressed: () => onTap())),
        ));
  }
}
