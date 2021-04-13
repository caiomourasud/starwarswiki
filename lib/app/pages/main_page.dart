import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwarswiki/app/controllers/app_controller.dart';
import 'package:starwarswiki/app/controllers/home_controller.dart';
import 'package:starwarswiki/app/controllers/settings_controller.dart';
import 'package:starwarswiki/code/breakpoints.dart';

import '../components/navigation/custom_navigation_rail.dart';
import 'view/destination.dart';

final _appController = Modular.get<AppController>();
final _homeController = Modular.get<HomeController>();
final _settingsController = Modular.get<SettingsController>();

bool isMenuOpen = false;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    _appController.setContext(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: LayoutBuilder(builder: (context, dimens) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottomNavigationBar: dimens.maxWidth <= dimens.maxHeight ||
                    MediaQuery.of(context).size.width <= md
                ? CupertinoTabBar(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Theme.of(context).hoverColor
                            : CupertinoColors.white,
                    currentIndex: _appController.indexSelected,
                    onTap: (index) {
                      FocusScope.of(context).unfocus();
                      _onTap(index);
                    },
                    items: allDestinations.asMap().entries.map((destination) {
                      return BottomNavigationBarItem(
                        icon: Icon(destination.value.icon, size: 26),
                        tooltip: destination.value.tooltip,
                      );
                    }).toList(),
                  )
                : SizedBox(),
            body: Row(
              children: [
                _leftMenu(dimens),
                VerticalDivider(
                  width: 0.1,
                ),
                Expanded(
                    child: ClipRect(
                  child: IndexedStack(
                    index: _appController.indexSelected,
                    children: allDestinations.map<Widget>((destination) {
                      return destination.pagina;
                    }).toList(),
                  ),
                )),
              ],
            ),
          );
        }));
  }

  void _onTap(int index) {
    FocusScope.of(context).unfocus();
    switch (index) {
      case 0:
        if (_appController.indexSelected == 0) {
          allDestinations[0].navigatorKey.currentState!.maybePop().then(
              (value) => !value
                  ? _animateToTop(_homeController.scrollController)
                  : null);
        }
        break;
      case 1:
        if (_appController.indexSelected == 1) {
          allDestinations[1].navigatorKey.currentState!.maybePop().then(
              (value) => !value
                  ? _animateToTop(_settingsController.scrollController)
                  : null);
        }
        break;
      case 2:
        if (_appController.indexSelected == 2) {
          allDestinations[2].navigatorKey.currentState!.maybePop().then(
              (value) => !value
                  ? _animateToTop(_settingsController.scrollController)
                  : null);
        }
        break;
      case 3:
        if (_appController.indexSelected == 3) {
          allDestinations[3].navigatorKey.currentState!.maybePop().then(
              (value) => !value
                  ? _animateToTop(_settingsController.scrollController)
                  : null);
        }
        break;
      default:
    }
    if (mounted)
      setState(() {
        _appController.indexSelected = index;
      });
  }

  Widget _leftMenu(BoxConstraints dimens) {
    if (dimens.maxWidth > dimens.maxHeight &&
        MediaQuery.of(context).size.width > md) {
      return CustomNavigationRail(
          dimens: dimens,
          indexSelected: _appController.indexSelected,
          itens: allDestinations,
          onTap: (index) => _onTap(index));
    } else {
      return SizedBox();
    }
  }

  void _animateToTop(ScrollController controller) {
    controller.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }
}
