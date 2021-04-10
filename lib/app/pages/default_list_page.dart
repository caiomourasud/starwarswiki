import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:starwarswiki/app/components/searchbar_widget.dart';
import 'package:starwarswiki/app/components/navigation/custom_sliver_appbar.dart';
import 'package:starwarswiki/app/components/sliver_fixed_widget.dart';
import 'package:starwarswiki/code/breakpoints.dart';

late FocusNode _focus;
late TextEditingController _buscar;
late ScrollController _scrollController;
double _scrollPosition = 0.0;

double searchSize = 0.0;
setSearchSize(value) => searchSize = value;

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
      required this.actions})
      : super(key: key);
  @override
  _DefaultListPageState createState() => _DefaultListPageState();
}

class _DefaultListPageState extends State<DefaultListPage> {
  @override
  void initState() {
    _focus = FocusNode();
    _buscar = TextEditingController();
    _scrollController = ScrollController();
    _focus.addListener(_onFocusChange);
    _scrollController.addListener(_scrollListener);
    _scrollPosition = 0.0;
    super.initState();
  }

  @override
  dispose() {
    _focus.dispose();
    _buscar.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    setState(() => _scrollPosition = _scrollController.position.pixels);
  }

  _onFocusChange() {
    setState(() {
      if (_focus.hasFocus == true || _buscar.text.isNotEmpty) {
        setSearchSize(64.0);
        _animateToTop(_scrollController, 52.0);
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints dimens) {
          return Row(
            children: [
              Container(
                height: double.infinity,
                width: width > md ? 380.0 : dimens.maxWidth,
                child: NestedScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    body: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      removeBottom: true,
                      child: Scrollbar(
                        child: CustomScrollView(
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
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        CustomSliverAppBar(
                          context: context,
                          title: widget.title,
                          backButton: widget.backButton,
                          position: _scrollPosition,
                          actions: widget.actions,
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
                  : Expanded(child: Center(child: Text(widget.noItemSelected)))
            ],
          );
        }),
      ),
    );
  }

  Widget _sliverBody(List itens, BoxConstraints dimens) {
    return widget.res || widget.list.isNotEmpty
        ? widget.listTile
        : widget.list.isEmpty
            ? SliverToBoxAdapter(
                child: Padding(
                padding: EdgeInsets.only(top: dimens.maxHeight / 3),
                child: Center(
                    child: Opacity(opacity: 0.4, child: Text('Nothing here'))),
              ))
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
