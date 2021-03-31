import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/components/navigation/custom_appbar.dart';
import 'package:starwarswiki/app/components/sliver_fixed_item.dart';
import 'package:starwarswiki/app/utils/preferences.dart';
import 'package:starwarswiki/code/breakpoints.dart';

StorageUtil _prefs = StorageUtil();
late FocusNode _focus;
TextEditingController _buscar = TextEditingController();

bool selectable = false;

class DefaultListPage extends StatefulWidget {
  final String title;
  final ScrollController scrollController;
  final double? scrollPosition;
  final Function(double)? setScrollPosition;
  final double searchSize;
  final Function(double) setSearchSize;
  final String searchText;
  final Function(String) setSearchText;
  final Function(bool?)? setShowFavorites;
  final Function getList;
  final Function(String) getMoreList;
  final bool res;
  final String nextText;
  final List list;
  final List filterList;
  final bool? showFavorites;
  final Widget listTile;
  final Widget detailsPage;
  final int itemSelectedId;
  final String noItemSelected;
  final List<Widget> actions;
  final List<Widget> titleActions;
  final List<Widget> appBarActions;
  final int backButton;

  const DefaultListPage(
      {Key? key,
      required this.title,
      required this.backButton,
      required this.scrollController,
      this.scrollPosition,
      this.setScrollPosition,
      required this.searchSize,
      required this.setSearchSize,
      required this.searchText,
      required this.setSearchText,
      this.setShowFavorites,
      required this.getList,
      required this.getMoreList,
      required this.res,
      required this.nextText,
      required this.list,
      required this.filterList,
      this.showFavorites,
      required this.listTile,
      required this.detailsPage,
      required this.itemSelectedId,
      required this.noItemSelected,
      required this.actions,
      required this.titleActions,
      required this.appBarActions})
      : super(key: key);
  @override
  _DefaultListPageState createState() => _DefaultListPageState();
}

class _DefaultListPageState extends State<DefaultListPage> {
  @override
  void initState() {
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
    if (widget.setScrollPosition != null)
      widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    widget.setScrollPosition!(widget.scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        widget.setSearchSize(64.0);
      } else {
        widget.setSearchSize(0.0);
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    widget.setSearchText('');
    widget.setSearchSize(0.0);
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
                    controller: widget.scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    body: Scrollbar(
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          CupertinoSliverRefreshControl(
                            refreshTriggerPullDistance: 100.0,
                            refreshIndicatorExtent: 60.0,
                            onRefresh: () async {
                              await Future<void>.delayed(
                                  const Duration(milliseconds: 1000));
                              if (widget.list.isEmpty) {
                                widget.getList();
                              } else {
                                _prefs.getString(widget.nextText).then((data) {
                                  if (data != '') {
                                    widget.getMoreList(data);
                                  }
                                });
                              }
                            },
                          ),
                          _sliverBody(widget.filterList, dimens),
                        ],
                      ),
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        if (!_focus.hasFocus ||
                            MediaQuery.of(context).size.width > md)
                          _sliverAppBar(),
                        if (_focus.hasFocus &&
                            MediaQuery.of(context).size.width <= md)
                          _appBar(),
                        SliverPersistentHeader(
                            pinned: true,
                            floating: false,
                            delegate: SearchBarWidget(
                                size: widget.searchSize,
                                buscar: _buscar,
                                focus: _focus,
                                backButton: widget.backButton,
                                onChange: (text) {
                                  widget.setSearchText(text);
                                },
                                cancelar: _cancelar,
                                texto: 'Search...',
                                fullDimens: dimens)),
                        if (widget.showFavorites != null)
                          SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: SliverFixedItem(
                                  widget.showFavorites! &&
                                          widget.searchText == ''
                                      ? 'Favorites'
                                      : widget.searchText == ''
                                          ? 'All'
                                          : 'Search result',
                                  Theme.of(context).scaffoldBackgroundColor,
                                  true)),
                        if (widget.showFavorites == null)
                          SliverPersistentHeader(
                              pinned: true,
                              floating: false,
                              delegate: SliverFixedItem(
                                  widget.searchText == ''
                                      ? 'All'
                                      : 'Search result',
                                  Theme.of(context).scaffoldBackgroundColor,
                                  true))
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
              widget.itemSelectedId == 0
                  ? Expanded(
                      child: Scaffold(
                          body: Center(child: Text(widget.noItemSelected))),
                    )
                  : Expanded(
                      child: ClipRect(child: widget.detailsPage),
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
      title: widget.title,
      backButton: widget.backButton,
      position: widget.scrollPosition,
      titleActions: widget.titleActions,
      actions: widget.actions,
    );
  }

  _appBar() {
    return SliverPersistentHeader(
        pinned: true,
        floating: false,
        delegate: CupertinoAppBarWidget(
          context: context,
          title: widget.title,
          backButton: widget.backButton,
          actions: widget.actions,
        ));
  }

  _sliverBody(List itens, BoxConstraints dimens) {
    return widget.res || widget.list.isNotEmpty
        ? widget.listTile
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
