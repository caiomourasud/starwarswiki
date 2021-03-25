import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/models/people.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/utils/conversores.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';
import 'character_details/character_details_page.dart';
import 'components/listtile_widget.dart';

final _charactersController = Modular.get<CharactersController>();

StorageUtil _prefs = StorageUtil();
FocusNode _focus = FocusNode();
TextEditingController _buscar = TextEditingController();
Conversores conversores = Conversores();

bool selectable = false;

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  void initState() {
    _focus.addListener(_onFocusChange);
    _charactersController.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    _charactersController.setScrollPosition(
        _charactersController.scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _charactersController.setSearchSize(78.0);
      } else {
        _charactersController.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    _charactersController.setSearchText('');
    _charactersController.setSearchSize(0.0);
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
                    controller: _charactersController.scrollController,
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
                                if (_charactersController.people.isEmpty) {
                                  _charactersController.getPeople();
                                } else {
                                  _prefs.getString('next_people').then((data) {
                                    if (data != '') {
                                      _charactersController.getMorePeople(data);
                                    }
                                  });
                                }
                              },
                            ),
                            _sliverBody(
                                _charactersController.filterCharacters, dimens),
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
                                  size: _charactersController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  onChange: (text) {
                                    _charactersController.setSearchText(text);
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
                  return _charactersController.personSelected.id == 0
                      ? Expanded(
                          child: Scaffold(
                              body:
                                  Center(child: Text('No character selected'))),
                        )
                      : Expanded(
                          child: ClipRect(
                            child: CharacterDetailsPage(
                                character:
                                    _charactersController.personSelected),
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
        title: 'Characters',
        leading: CupertinoButton(
            minSize: 34,
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(50.0),
            color: Colors.transparent,
            child: Icon(CupertinoIcons.person_crop_circle_fill,
                size: 26, color: Colors.red[600]),
            onPressed: () {
              setState(() {
                _charactersController.clearListPeople();
                _charactersController.clearPeopleBox();
              });
            }),
        position: _charactersController.scrollPosition,
        titleActions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 16.0,
              disable: false,
              onTap: () => _charactersController.setShowFavorites(null))
        ],
        actions: [
          _listFavorites(
              paddingTop: 4.0,
              paddingRight: 0.0,
              disable: _charactersController.scrollPosition <= 35.0,
              onTap: () => _charactersController.setShowFavorites(null))
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
            title: 'Characters',
            leading: CupertinoButton(
              minSize: 34,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.transparent,
              child: Icon(CupertinoIcons.person_crop_circle_fill,
                  size: 26, color: Colors.red[600]),
              onPressed: () {
                setState(() {
                  _charactersController.clearListPeople();
                  _charactersController.clearPeopleBox();
                });
              },
            ),
            actions: [
              _listFavorites(
                  paddingTop: 4.0,
                  paddingRight: 0.0,
                  disable: false,
                  onTap: () => _charactersController.setShowFavorites(null))
            ],
          ));
    });
  }

  _sliverBody(List<People> people, BoxConstraints dimens) {
    return _charactersController.res || _charactersController.people.isNotEmpty
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return ListTileWidget(
                personSelected: _charactersController.personSelected,
                person: people[index],
                onTap: (character) {
                  if (MediaQuery.of(context).size.width <= md) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return CharacterDetailsPage(character: character);
                    }));
                  }
                  setState(() {
                    _charactersController.setPersonSelected(character);
                  });
                },
                onFavoriteTap: (id) {
                  setState(() {
                    _charactersController.setFavorito(id);
                  });
                },
              );
            }, childCount: people.length),
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
                  message: _charactersController.showFavorites
                      ? 'Listar todos'
                      : 'Listar favoritos',
                  child: CupertinoButton(
                      minSize: 34,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.transparent,
                      child: Icon(
                          _charactersController.showFavorites
                              ? CupertinoIcons.square_favorites_alt_fill
                              : CupertinoIcons.square_favorites_alt,
                          size: 28,
                          color: Colors.red[600]),
                      onPressed: () => onTap())),
        ));
  }
}
