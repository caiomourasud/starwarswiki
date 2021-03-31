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

int indexSelected = 0;
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
            bottomNavigationBar: dimens.maxWidth <= dimens.maxHeight ||
                    MediaQuery.of(context).size.width <= md
                ? CupertinoTabBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    currentIndex: indexSelected,
                    onTap: (index) {
                      FocusScope.of(context).unfocus();
                      _onTap(index);
                    },
                    items: allDestinations.asMap().entries.map((destination) {
                      return BottomNavigationBarItem(
                        // label: indexSelected == destination.key
                        //     ? destination.value.tooltip
                        //     : null,
                        icon: Icon(destination.value.icon, size: 24),
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
                Expanded(child: _buildBody()),
              ],
            ),
          );
        }));
  }

  void _onTap(int index) {
    FocusScope.of(context).unfocus();
    switch (index) {
      case 0:
        if (indexSelected == 0) {
          _animateToTop(_homeController.scrollController);
        }
        break;
      case 1:
        if (indexSelected == 1) {
          _animateToTop(_settingsController.scrollController);
        }
        break;
      case 2:
        if (indexSelected == 2) {
          _animateToTop(_settingsController.scrollController);
        }
        break;
      case 3:
        if (indexSelected == 3) {
          _animateToTop(_settingsController.scrollController);
        }
        break;
      default:
    }
    if (mounted)
      setState(() {
        indexSelected = index;
      });
  }

  _buildBody() {
    return ClipRect(
      child: SafeArea(
        top: false,
        child: IndexedStack(
          index: indexSelected,
          children: allDestinations.map<Widget>((destination) {
            return destination.pagina;
          }).toList(),
        ),
      ),
    );
  }

  _leftMenu(BoxConstraints dimens) {
    if (dimens.maxWidth > dimens.maxHeight &&
        MediaQuery.of(context).size.width > md) {
      return CustomNavigationRail(
          dimens: dimens,
          indexSelected: indexSelected,
          itens: allDestinations,
          onTap: (index) => _onTap(index));
    } else {
      return SizedBox();
    }
  }

  _animateToTop(ScrollController controller) {
    controller.animateTo(0.0,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }
}
