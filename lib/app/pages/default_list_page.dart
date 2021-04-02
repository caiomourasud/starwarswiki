import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/components/navigation/custom_sliver_appbar.dart';
import 'package:starwarswiki/app/components/sliver_fixed_item.dart';
import 'package:starwarswiki/code/breakpoints.dart';

late FocusNode _focus;
TextEditingController _buscar = TextEditingController();
late ScrollController _scrollController;
late ScrollController _customScrollController;
double _scrollPosition = 0.0;

double searchSize = 0.0;
setSearchSize(newValue) => searchSize = newValue;

bool selectable = false;

class DefaultListPage extends StatefulWidget {
  final String title;
  final String searchText;
  final Function(String) setSearchText;
  final Function(bool?)? setShowFavorites;
  final Function getList;
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
      required this.searchText,
      required this.setSearchText,
      this.setShowFavorites,
      required this.getList,
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
    _scrollController = ScrollController();
    _customScrollController = ScrollController();
    _focus.addListener(_onFocusChange);
    _scrollController.addListener(_scrollListener);
    _scrollPosition = 0.0;
    super.initState();
  }

  @override
  dispose() {
    _focus.dispose();
    _scrollController.dispose();
    _customScrollController.dispose();
    _scrollPosition = 0.0;
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.position.pixels >= -10.0 &&
        _scrollController.position.pixels <= 60.0) {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
    }
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        setSearchSize(64.0);
        _animateToTop(_scrollController, 60.0);
      } else {
        setSearchSize(0.0);
        if (_scrollController.position.pixels <= 100.0) {
          _animateToTop(_scrollController, 0.0);
        }
      }
    });
  }

  _cancelar() {
    _buscar.clear();
    widget.setSearchText('');
    setSearchSize(0.0);
    if (_scrollController.position.pixels <= 100.0) {
      _animateToTop(_scrollController, 0.0);
    }
    FocusScope.of(context).unfocus();
  }

  _animateToTop(ScrollController controller, double position) {
    controller.animateTo(position,
        duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:
          LayoutBuilder(builder: (BuildContext context, BoxConstraints dimens) {
        return Row(
          children: [
            Container(
              height: double.infinity,
              width: width > md ? 380.0 : dimens.maxWidth,
              child: NestedScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  body: Scrollbar(
                    child: CustomScrollView(
                      // keyboardDismissBehavior:
                      //     ScrollViewKeyboardDismissBehavior.onDrag,
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        CupertinoSliverRefreshControl(
                          refreshTriggerPullDistance: 100.0,
                          refreshIndicatorExtent: 60.0,
                          onRefresh: () async {
                            await Future<void>.delayed(
                                const Duration(milliseconds: 1000));
                            widget.getList();
                          },
                        ),
                        _sliverBody(widget.filterList, dimens),
                      ],
                    ),
                  ),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      CustomSliverAppBar(
                        context: context,
                        title: widget.title,
                        backButton: widget.backButton,
                        position: _scrollPosition,
                        titleActions:
                            _scrollPosition <= 35.0 ? widget.titleActions : [],
                        actions: _scrollPosition > 35.0 ? widget.actions : [],
                      ),
                      SliverPersistentHeader(
                          pinned: true,
                          floating: false,
                          delegate: SearchBarWidget(
                              size: searchSize,
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
                                widget.showFavorites! && widget.searchText == ''
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
            if (width > md)
              VerticalDivider(
                width: 0.1,
              ),
            if (width > md)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  height: double.infinity,
                  width: 0.08,
                  color: Colors.grey,
                ),
              ),
            widget.itemSelectedId > 0 && width > md
                ? Expanded(
                    child: ClipRect(child: widget.detailsPage),
                  )
                : Expanded(
                    child: Scaffold(
                        body: Center(child: Text(widget.noItemSelected))),
                  ),
          ],
        );
      }),
    );
  }

  Widget _sliverBody(List itens, BoxConstraints dimens) {
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
