import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/components/custom_appbar.dart';
import 'package:starwarswiki/app/pages/characters/character_detail/character_detail_page.dart';
import 'package:starwarswiki/app/pages/characters/characters_controller.dart';
import 'package:starwarswiki/app/utils/conversores.dart';
import 'package:starwarswiki/code/breakpoints.dart';
import 'package:starwarswiki/db/people_table.dart';
import 'components/listtile_widget.dart';

import 'package:http/http.dart' as http;

final _charactersController = Modular.get<CharactersController>();

late ScrollController scrollController = ScrollController();

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
    _charactersController.clearListPeople();
    _focus.addListener(_onFocusChange);
    scrollController.addListener(scrolllistener);
    super.initState();
  }

  scrolllistener() {
    _charactersController.setPosition(scrollController.position.pixels);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CupertinoPageScaffold(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints dimens) {
          return Observer(builder: (_) {
            return Row(
              children: [
                Container(
                  height: double.infinity,
                  width: dimens.maxWidth > md ? 380.0 : dimens.maxWidth,
                  child: NestedScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      body: Scrollbar(
                        child: CustomScrollView(
                          slivers: [
                            CupertinoSliverRefreshControl(
                              refreshTriggerPullDistance: 100.0,
                              refreshIndicatorExtent: 60.0,
                              onRefresh: () async {
                                await Future<void>.delayed(
                                    const Duration(milliseconds: 1000));
                                setState(() {
                                  getPeople();
                                });
                              },
                            ),
                            if (_charactersController.listPeople.isNotEmpty)
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    PeopleTable person = _charactersController
                                        .listPeople
                                        .toList()[index];
                                    return ListTileWidget(
                                      personSelected:
                                          _charactersController.personSelected,
                                      person: person,
                                      dimens: dimens,
                                      onTap: (character) {
                                        _charactersController
                                            .setPersonSelected(character);
                                        if (dimens.maxWidth <= md)
                                          Navigator.push(context,
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return CharacterDetailPage(
                                                character: person);
                                          }));
                                      },
                                    );
                                  },
                                  childCount: _charactersController.listPeople
                                      .toList()
                                      .length,
                                ),
                              ),
                          ],
                        ),
                      ),
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          if (!_focus.hasFocus || dimens.maxWidth > md)
                            Observer(builder: (_) {
                              return CupertinoSliverAppBarWidget(
                                context: context,
                                title: 'Characters',
                                leading: CupertinoButton(
                                    minSize: 34,
                                    padding: EdgeInsets.zero,
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.transparent,
                                    child: Icon(
                                        CupertinoIcons.person_crop_circle_fill,
                                        size: 26,
                                        color: Colors.red[600]),
                                    onPressed: () {}),
                                position: _charactersController.position,
                                titleActions: [
                                  listaFavortos(
                                      paddingTop: 4.0,
                                      paddingRight: 16.0,
                                      disable: false)
                                ],
                                actions: [
                                  listaFavortos(
                                      paddingTop: 4.0,
                                      paddingRight: 0.0,
                                      disable: false)
                                ],
                              );
                            }),
                          if (_focus.hasFocus && dimens.maxWidth <= md)
                            Observer(builder: (_) {
                              return SliverPersistentHeader(
                                  pinned: true,
                                  floating: false,
                                  delegate: CupertinoAppBarWidget(
                                    context: context,
                                    title: 'Characters',
                                    leading: CupertinoButton(
                                        minSize: 34,
                                        padding: EdgeInsets.zero,
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        color: Colors.transparent,
                                        child: Icon(
                                            CupertinoIcons
                                                .person_crop_circle_fill,
                                            size: 26,
                                            color: Colors.red[600]),
                                        onPressed: () {}),
                                    actions: [
                                      listaFavortos(
                                          paddingTop: 4.0,
                                          paddingRight: 0.0,
                                          disable: false)
                                    ],
                                  ));
                            }),
                          CupertinoSliverRefreshControl(
                            refreshTriggerPullDistance: 100.0,
                            refreshIndicatorExtent: 60.0,
                            onRefresh: () async {
                              await Future<void>.delayed(
                                  const Duration(milliseconds: 1000));
                              getPeople();
                            },
                          ),
                          SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: SearchBarWidget(
                                  size: _charactersController.searchSize,
                                  buscar: _buscar,
                                  focus: _focus,
                                  onChange: (text) {
                                    setState(() {});
                                  },
                                  cancelar: cancelar,
                                  apagar: apagar,
                                  texto: 'Search...',
                                  fullDimens: dimens)),
                        ];
                      }),
                ),
                if (dimens.maxWidth > md)
                  VerticalDivider(
                    width: 0.1,
                  ),
                if (dimens.maxWidth > md)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      height: double.infinity,
                      width: 0.08,
                      color: Colors.grey,
                    ),
                  ),
                _charactersController.personSelected.id == 0
                    ? Expanded(
                        child: Scaffold(
                            body: Center(child: Text('No character selected'))),
                      )
                    : Expanded(
                        child: ClipRect(
                          child: CharacterDetailPage(
                              character: _charactersController.personSelected),
                        ),
                      )
              ],
            );
          });
        }),
      ),
    );
  }

  listaFavortos(
      {required double paddingTop,
      required double paddingRight,
      required bool disable}) {
    return MouseRegion(
        cursor: disable ? MouseCursor.defer : SystemMouseCursors.click,
        child: Padding(
          padding: EdgeInsets.only(top: paddingTop, right: paddingRight),
          child: disable
              ? CupertinoButton(
                  minSize: 34,
                  padding: EdgeInsets.zero,
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.transparent,
                  child: Icon(CupertinoIcons.square_favorites_alt_fill,
                      size: 28, color: Colors.red[600]),
                  onPressed: () {})
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
                    onPressed: () => _charactersController.setFavorites(null),
                    // setState(() => showFavorites = !showFavorites),
                  )),
        ));
  }

  void getPeople() async {
    _charactersController.clearListPeople();
    _charactersController.res = false;
    String _url = 'https://swapi.dev/api/people/';
    var resposta = await http.get(Uri.parse(_url));
    var jsonData = jsonDecode(resposta.body);
    _charactersController.next = jsonData['next'].replaceAll('http', 'https');
    Iterable films = jsonData['results'];
    films.map((person) {
      _charactersController.addListPeople(PeopleTable.fromJson(person));
    }).toList();
    print(_charactersController.next);
    _charactersController.res = true;
    if (_charactersController.res) getMorePeople(_charactersController.next);
    setState(() {});
  }

  void getMorePeople(String link) async {
    _charactersController.res = false;
    var resposta = await http.get(Uri.parse(link));
    var jsonData = jsonDecode(resposta.body);
    Iterable people = jsonData['results'];
    people.map((person) {
      _charactersController.addListPeople(PeopleTable.fromJson(person));
    }).toList();
    _charactersController.res = true;
    if (jsonData['next'] != null) {
      _charactersController.next = jsonData['next'].replaceAll('http', 'https');
    } else {
      _charactersController.next = '';
    }
    print(_charactersController.next);
    if (_charactersController.next != '' && _charactersController.res)
      getMorePeople(_charactersController.next);
    setState(() {});
  }

  void _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        _charactersController.setSearchSize(78.0);
      } else {
        _charactersController.setSearchSize(0.0);
      }
    });
  }

  cancelar() {
    _buscar.clear();
    _charactersController.setSearchSize(0.0);
    FocusScope.of(context).unfocus();
  }

  apagar() {
    setState(() {
      _buscar.clear();
    });
  }
}
